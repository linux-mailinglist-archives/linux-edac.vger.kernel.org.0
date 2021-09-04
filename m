Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190FD400B2A
	for <lists+linux-edac@lfdr.de>; Sat,  4 Sep 2021 13:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbhIDLYf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 4 Sep 2021 07:24:35 -0400
Received: from mout.gmx.net ([212.227.15.19]:33071 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234482AbhIDLYf (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sat, 4 Sep 2021 07:24:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630754598;
        bh=oNeNfx2Pff1MWMSsLtAuLuPTtNZrnmhUxJ32Wbzy0PQ=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Dq4T0yIIxdhcaG7ubWZf6umefhUbVnJM96o4nRUvZeFWuKlp6+2tV6tTi9eh9dhYi
         n4Zm24xU9PW5q/JZkCB5PAx4Px5jd7tz3NDYZ6DVlN0SvonHW9+PJWz79bzDwt0jfB
         9n69iEydC1gJzeA9iRqfcn49u+yYcfc7a4SWdJMw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from titan ([79.150.72.99]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M6Db0-1mKGqc2Geu-006fjl; Sat, 04
 Sep 2021 13:23:18 +0200
Date:   Sat, 4 Sep 2021 13:23:03 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Joe Perches <joe@perches.com>
Cc:     Len Baker <len.baker@gmx.com>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] EDAC/mc: Prefer strscpy or scnprintf over strcpy
Message-ID: <20210904094451.GA2998@titan>
References: <20210903150539.7282-1-len.baker@gmx.com>
 <3a035a3ec4571a622ce640e042f9a119@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a035a3ec4571a622ce640e042f9a119@perches.com>
X-Provags-ID: V03:K1:NdVm4hX0KwBB2OaFVM6rjj/Cadbwqs5ugUJfNJk7Ty+WXs1tLIe
 cd8ytx9mGoQ1OW+qjqlWJO1rXOQxyIt1P4fm8Mn29xxlljrZ+lXG3q04Wmo9dXo8cERCtn0
 cOX3p0pDk30ysHvv+juk+ncPbBJebBwLsIKbswEJLA1kui0gQKWJsJpQa/k+zUui6IjEHTH
 lUWFNgv8gI3TmFG+W8sww==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+kOwGOz9i50=:n3oD+TWpsWVH3tZ47rLE33
 xNKfDTS10b1eWX3wB4Yarw9c59AWrxRQd6QXhd2CnnzYVKy6ujAdQApf1GG6qu9JdGXM2zJFV
 7jli3iY6Rc7WMXezeImPqXDSByr3NLpgvxdaiazkhhYZ31QiTl0Af91ajdRXpU3JyhvfTA8+n
 dNUxTsheNJP4CgI19FDD3OlZdK4SannMVX7f1MkB1btpM4pgQ7OH90Hrq87SBer+R92FsnOi+
 cM9qwFZYeH9zqrisJ01wXulEv6EUpzQdqBKbiBBdq7uxnwcnwC23mb4mhTxJW+/5QtNJMNNW+
 C5FBFVm7iBBwiVt9aNvkfbr+tZjL3jqMsGgbYOqqbbt6MyM0PCcQVwPAr57L2Q8J2tAFJYeP/
 MEIQHb8493jqt5e1qNoXOiW8TUVAqq17k+DZLcVkRc8BNPQqv9iRRUiVH3t3H1lgV0maRO7g4
 It50hJ3iZvKiHjeWBFgtPX+WwmjXFkFmgzeLY6okJd37m5jgSOYE9h6ZFLpWN1dcAsX3Q6S8Y
 GeOZ4NAUPhVlzgokTnSWz3FH+T7UWreq1eB8nT6kLM+VRjuZXzExAf1bx4CQzg6AN60lunxcU
 KP8B1R/ILroWP0CYimeXtIqp02A1GWF0935yhVPLSWlUns9CQZHmV9GnP/sa35w7ruS9GeDQK
 dTuHO1k3Tt6XvEmtS62A4FU+zgBv6HURI/8ARpJ7cPrYY/I1L68EVwOE+2FfusVkEqJKtkJI1
 WP2VkWvRJGiseEXbRP4qUyMsdGBD64FxTlE8uUaKIR2Mpy5Api2/6VTYDN0nMbD/gdFZSvf9Z
 7su3MpJSFU98JXalmmGNW0P+q8u8euThJO7NECBGuCga9f3/KusE9/ueeBRQRo6s7MYzOfWPD
 faVmwKWHErErrqDrEQ0VZRunCRL4wGq0w9cFFob+4yUb+LY/VcwD5n+GaTQAFNzy64bhfe2JO
 70f4AkNUE7Cc6NUEJGDfhSoj769f3sjid1Gbf2sU2Ir6TGp7SPlRyjjTutWT7y6bJIPFlf93a
 fZV4C8L5tcDGUaqTIkBMTWx4S0CkwE0kA/z+2A61vIZJ4Iov90OrKgzrWu4Kl2r5pE3RmS1wV
 /gjmct5YEhWaS+F/+EFuprjyliYuSIDBBsyVtamhQIz5YFmBi0xksQVvQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi,

On Fri, Sep 03, 2021 at 10:03:18AM -0700, Joe Perches wrote:
> On 2021-09-03 08:05, Len Baker wrote:
> > strcpy() performs no bounds checking on the destination buffer.
> > len.baker@gmx.com/
>
> []
>
> > @@ -1113,12 +1115,9 @@ void edac_mc_handle_error(const enum
> > hw_event_mc_err_type type,
> >  			p =3D e->label;
> >  			*p =3D '\0';
> >  		} else {
> > -			if (p !=3D e->label) {
> > -				strcpy(p, OTHER_LABEL);
> > -				p +=3D strlen(OTHER_LABEL);
> > -			}
> > -			strcpy(p, dimm->label);
> > -			p +=3D strlen(p);
> > +			n +=3D scnprintf(e->label + n, sizeof(e->label) - n,
> > +				       "%s%s", prefix, dimm->label);
> > +			prefix =3D OTHER_LABEL;
>
> OTHER_LABEL is a define specific to this module
>
> IMO: Used once text macros are just obfuscating and should be removed.

This macro is used in "/include/linux/edac.h" as follows:

struct edac_raw_error_desc {
	[...]
	char label[(EDAC_MC_LABEL_LEN + 1 + sizeof(OTHER_LABEL)) * EDAC_MAX_LABEL=
S];
	[...]
};

If we remove this define the size of label would be:

	char label[(EDAC_MC_LABEL_LEN + 6) * EDAC_MAX_LABELS];

So, I think now is more complicated to understand because the size is
what it is. If you prefer this option, I can remove the macro and add
a comment with some explanation.

Regards,
Len
