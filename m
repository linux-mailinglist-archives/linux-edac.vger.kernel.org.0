Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA2C400127
	for <lists+linux-edac@lfdr.de>; Fri,  3 Sep 2021 16:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbhICOXN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 3 Sep 2021 10:23:13 -0400
Received: from mout.gmx.net ([212.227.17.21]:32797 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232812AbhICOXM (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 3 Sep 2021 10:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630678918;
        bh=xTkzBR/NM1ERixuFBW/fGGwiCbZBIA3xA3CMLB2QmJw=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=RupMdxxCbwjHI9MZb0vuvl7bMomnYh0hykDd24i8jnSyAY2qSSeifZ1vuNDEHI/CE
         bOT/+9khCIRwqRw9sECBv3ugrn/JZfcFwhAyQaaKMbU0Ve9FMzvRfX/wXOKqGA/JJU
         9Nr1b1Ev/GP0Sv8HtI2UbTPM6cAdtoPBMnKjitb0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from titan ([79.150.72.99]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N7QxB-1n3Vbn1l1B-017iRL; Fri, 03
 Sep 2021 16:21:58 +0200
Date:   Fri, 3 Sep 2021 16:21:46 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Joe Perches <joe@perches.com>
Cc:     Len Baker <len.baker@gmx.com>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] EDAC/mc: Prefer strscpy or scnprintf over strcpy
Message-ID: <20210903142146.GA1998@titan>
References: <20210829161547.6069-1-len.baker@gmx.com>
 <7b6dc45194f28db52740c2a604550f6879dafe36.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <7b6dc45194f28db52740c2a604550f6879dafe36.camel@perches.com>
X-Provags-ID: V03:K1:Z6nRG9qR9L/iEr0xkfe+W1s3Dcdd6mqSG6HqjwqH6IbacZI+saw
 yrf4hgBnonxvHtfN7G1AIPyKBUaJ4/j9D9SZd7ubn+BFJ792en5vJ8cAzdinriVdLM7UCmS
 Jw3jlNMeBxGlMnbhjJlcj3vkjZUsy/Ad6Jro5x+j4/KA36h0CYYvPhp1WIUmbf4Dp8ibJAX
 ZTqZCCho1jpPgiB8L4xCg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:iYYl9QrDFaI=:vEdMFGqCEoibtpcI+ysMzt
 7y6beWEh5NBzNMNttWkX4VLFbPQsvdxNAiBPFUtFpA2mkeRiBqVYI/4ec4g2KRmuS425sMlii
 RUwcp9mLb1l3D7rBhaZv8w+rhqZ05urvQK9mPRbF9HYJS52Cdk3a8rrWMZrMqqLQLsi4uaaST
 H0Md7Y8dr0Hc5HuqRS0iUvnD1O/mr8l3URyRFif6Wmy7JrjOVlJI4Ev3rcyJlRk198N6cCcZh
 Uk15BQR83gFjNRfrNGuXwxWZJXphRXrJVHlPqBItJMZvJUgRP1//L3VUYpMkTeKC0Huw/7/9+
 OE/HIotSpCFxlpbQ7UZfq8twSa5HdAnLIOba5peiUnziAtPwhJ9yah/xzjjolR2CUC3rV2Khw
 tgg3p14h3KgjuRZWBOWksJrT7W0KfZwwhw90iuwxocDDtyWw8qNkNSeAETEldwqQyPTcn2a4E
 9m9MWb097a487PdYU06XxMJ0yAS0ARJRZ9SdLdVFq87uVbN6rw46ndQ5msoQeOEvK/c6wJ0+q
 orXseIoSfBIkdzP7J8cGpJ1DsdCiA2Ps51qydrXeY4H6pSj2alnXse9yv1BoN316miAQ3ytGc
 3MJcpi4J6wYW4JfaC+DrBssZbIzhcJoupWIPrNSxB4eMmGBtW8HMlztTO/QnxqGXURaPkNDU+
 y+F4T9BP9OyDTz1hfBZJr58tYdz+Qa3UWkhBp8RnYShkHbLKaj0DnGxBR3voJ/MUdgBAi6dFM
 c/JT6O/f/4Vv6eRsVQ6GVv4CLyS5StbTSA9U+GIyDGuTqG+jfpOrPuomXNldglSWRJn3+2noE
 G9D2UpnGOWu8DL/P/sj04MK0NwKcfGMPsGbXVOXUnN8dgUkNKYDL4ZVz8Q8hHxKpycM4Rq8uX
 uiEz/ZEUBX+yKWpSCYmtS0fH97zMJug+opgxZVvfWy6ED0HnBguSSqm5nLZUvbIgv7oV6YyZ6
 8T22jjA1NqjwgV85J/Au6ODjQdsFmUVD18q6XOolOINujwwuZ9mIgNDcOn/U3stzX33bdvGj9
 UVd2lenXWovNpHiqdRXd9m/zDqCK7qx4Evvlyr7evh8tQgq83F1KzCzWXkKWgaR5CghZc8/y2
 mKy9fIhtVNo95ko1IKjLtLw+K/5gneSDLl5sES653RssKgfc6gctXoVIQ==
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi,

On Sun, Aug 29, 2021 at 09:38:37AM -0700, Joe Perches wrote:
> On Sun, 2021-08-29 at 18:15 +0200, Len Baker wrote:
> > strcpy() performs no bounds checking on the destination buffer. This
> > could result in linear overflows beyond the end of the buffer, leading
> > to all kinds of misbehaviors. The safe replacement is strscpy() [1].
> >
> > However, to simplify and clarify the code, to concatenate labels use
> > the scnprintf() function. This way it is not necessary to check the
> > return value of strscpy (-E2BIG if the parameter count is 0 or the src
> > was truncated) since the scnprintf returns always the number of chars
> > written into the buffer. This function returns always a nul-terminated
> > string even if it needs to be truncated.
> []
> > diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> []
> > @@ -1113,12 +1116,11 @@ void edac_mc_handle_error(const enum hw_event_=
mc_err_type type,
> > =A0			p =3D e->label;
> > =A0			*p =3D '\0';
> > =A0		} else {
> > -			if (p !=3D e->label) {
> > -				strcpy(p, OTHER_LABEL);
> > -				p +=3D strlen(OTHER_LABEL);
> > -			}
> > -			strcpy(p, dimm->label);
> > -			p +=3D strlen(p);
> > +			const char *or =3D (p !=3D e->label) ? OTHER_LABEL : "";
> > +
> > +			n =3D scnprintf(p, len, "%s%s", or, dimm->label);
> > +			len -=3D n;
> > +			p +=3D n;
>
> A very common and intelligible mechanism for this is:
>
> 	const char *prefix =3D "";
> 	int n =3D 0;
> 	...
> 			n +=3D scnprintf(e->label + n, sizeof(e->label) - n,
> 				       "%s%s", prefix, dimm->label);
> 			prefix =3D " or ";
>
Ok, I will send a new version using this common mechanism. Thanks for the
advise.

Regards,
Len
