---
title: Kullback–Leibler divergence
cover-image: kldivergence.jpg

summary: KL divergence has a significant relationship with machine learning. I first encountered the ML - KL divergence relationship while studying variational inference in Probabilistic Graphical Models class. Since then I've encountered this premetric in every machine learning paper that has its basis in variational inference theory. Let's take a walk through this simple measure in its distilled form.
---

KL divergence is a [premetric](https://en.wikipedia.org/wiki/Metric_(mathematics)#Premetrics) that finds its root in information theory. It has a close relationship with [Shannon entropy](https://en.wiktionary.org/wiki/Shannon_entropy) and we'll walk through this relationship in the subsequent discussion. In its most basic sense, KL divergence measures the proximity between distributions. When we talk about KL divergence between two distribution say P and Q, it's denoted as

$$D_{KL} \left(P  \Vert  Q\right)$$

### Mathematical background

KL divergence belongs to a class of divergence measures known as <i>f-divergence</i>. For distributions P and Q and  a convex function f(t) defined over t > 0 with f(1) = 0 is given by

$$D_{f} \left(P  \Vert Q\right) = \sum_{t} Q(t) f\Big(\frac{P(t)}{Q(t)}\Big)$$

To derive KL divergence we set f(t) = t log t. For P(t) = Q(t) = 0, f-divergence is taken as zero. As per literature, KL divergence $$D_{KL} \left(P  \middle\|  Q\right)$$ requires P to be <i>absolute continuous</i>. Mathematically, this would mean KL divergence is undefined when for any t, P(t) $$\neq$$ 0 but Q(t) = 0. An intuitive explanation for this will be presented later.

Three important properties of KL divergence are:-
* $$D_{KL} \left(P  \Vert  Q\right) \geq 0$$. The equality happens when P = Q everywhere. This is known as Gibb's inequality.
* In general, $$D_{KL} \left(P  \Vert  Q\right) \neq D_{KL} \left(Q  \Vert  P\right)$$. That means KL divergence is not symmetric and hence is not a metric/distance measure.
* KL divergence doesn't obey triangle inequality.

### Shannon entropy 

In computer science theory, entropy is one of the most studied topics. Thanks to Claude Shannon who gave us Shannon entropy. For a random variable X with PMF P(X), Shannon entropy is defined as

$$H(X) = - \sum_{x}P(x)\hspace{0.2cm}log_{2}\left(\hspace{0.1cm}P(x)\right)$$

Intuitively, entropy gives us the lower bound on the number of bits required to optimally encode each observation of x. However, it must be kept in mind that we don't get to know what the optimal encoding is! The choice of use logarithm base 2 comes from information theory literature leading to entropy's unit as bits.

### KL divergence and its relationship with entropy

We saw that KL divergence is defined as $$D_{KL} \left(P  \Vert  Q\right) = \sum_{x} P(x) log\Big(\frac{P(x)}{Q(x)}\Big)$$. Let's rewrite this by expanding the log term. We get,

$$
\begin{align}
D_{KL} \left(P  \Vert Q\right) &= \sum_{x} P(x) log\Big(\frac{P(x)}{Q(x)}\Big) \\
&= \sum_{x} P(x) log(P(x)) - \sum_{x} P(x) log(Q(x)) \\
&= -H(X) + H(P, Q)
\end{align}
$$

The two terms in the final step are well known. H(X) is the Shannon entropy which we described in the previous section. H(P, Q) is, yeah you probably guessed it, cross-entropy. Using Gibbs inequality, we can say that cross entropy is always greater than or equal to the corresponding Shannon entropy. 

Now, we describe KL divergence in terms of Shannon entropy and cross-entropy. Shannon entropy as we said above is the minimum number of bits required to optimally encode a distribution. Cross-entropy H(P, Q) on the other hand is the number of bits required to encode distribution P using an encoding that's optimal for distribution Q but not for P. Consequently, KL divergence is the expected number of extra bits that are used under this sub-optimal encoding. 

Let's revisit the discussion on why we require P to be <i>absolute continuous</i>. Having Q(x) = 0 when $$P(x) \neq 0$$ would mean that we're trying to approximate a <i>probable</i> event with something that's definitely not going to happen. So, when such an event happens (in distribution P), KL divergence would essentially diverge logarithmically. In other words, the sub-optimal encoding has no way to encode such an event! So, KL divergence is undefined in such a case.

### Treading to machine learning domain

In most of the ML algorithms, we resort to optimising cross entropy and not KL divergence because the Shannon entropy term is independent of the model parameters and acts like a constant when taking derivative of log-likelihood. In fact, it can be shown that minimizing KL divergence is equivalent to minimizing negative log-likelihood.

Let P = $$p\left(x \vert \theta^{*}\right)$$ be the true data distribution and model distribution be Q = $$p\left(x \vert \theta \right)$$. Then by definition of KL divergence,

$$
\begin{align}
D_{KL}[P(x \vert \theta^*) \, \Vert \, P(x \vert \theta)] &= \mathbb{E}_{x \sim P(x \vert \theta^*)}\left[\log \frac{P(x \vert \theta^*)}{P(x \vert \theta)} \right] \\
        &= \mathbb{E}_{x \sim P(x \vert \theta^*)}\left[\log \, P(x \vert \theta^*) - \log \, P(x \vert \theta) \right] \\
        &= H(X) - \mathbb{E}_{x \sim P(x \vert \theta^*)}\left[\log \, P(x \vert \theta) \right]
\end{align}
$$

For a large number of samples drawn from the true distribution we have $$\frac{1}{N} \sum_x \log \, P(x \vert \theta) = \mathbb{E}_{x \sim P(x \vert \theta^*)}\left[\log \, P(x \vert \theta) \right]$$ using the law of large numbers. Left-hand side in the equation represents log-likelihood of data samples. Comparing this result with the derivation above we can conclude that minimizing KL divergence is equivalent to minimizing negative log-likelihood.

These results have been used in variational inference theory and the most recent examples are Variational Autoencoders. The discussion about VAEs is reserved for another post. But you can read about them in this [Tutorial on Variational Autoencoders](https://arxiv.org/pdf/1606.05908.pdf) by [Carl Doersch](http://www.carldoersch.com/).

<sub>Cover credit: <a href="https://www.flickr.com/photos/shonk/7537733822/">shonk</a> via <a href="https://visualhunt.com/re/59119f">Visual Hunt</a> / <a href="http://creativecommons.org/licenses/by-nc-nd/2.0/"> CC BY-NC-ND</a></sub>
