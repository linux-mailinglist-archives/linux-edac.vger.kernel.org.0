Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA4C3DC6C9
	for <lists+linux-edac@lfdr.de>; Sat, 31 Jul 2021 17:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbhGaP6D (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 31 Jul 2021 11:58:03 -0400
Received: from mout.gmx.net ([212.227.17.22]:49647 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231620AbhGaP6D (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sat, 31 Jul 2021 11:58:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627747062;
        bh=Xm1amlEG94SkmNEYoJRd4JlIQcoNXkSXteU6QuLhcqQ=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=cNyw8xjmmavs83IBAh15l5L6hwjM2f9YueREuAZj9XG4wJlmO7vh+gJZ10T71f79c
         2I/tcR84g4GM2I9EvTVLTQPZ15/dA+IvFhLVA2aU0EUmSivMgFb1xhKFXTxi3+44Ac
         2zHumL0zZ6tV8zQVUSWkYL9r8rBhNkcxvkoUUTg8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from titan ([79.150.72.99]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M9Fnj-1mDQ8H0YAZ-006Qrl; Sat, 31
 Jul 2021 17:57:42 +0200
Date:   Sat, 31 Jul 2021 17:57:39 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Robert Richter <rric@kernel.org>
Cc:     Len Baker <len.baker@gmx.com>, Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        linux-hardening@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/edac/edac_mc: Remove all strcpy() uses
Message-ID: <20210731142759.GD1979@titan>
References: <20210725162954.9861-1-len.baker@gmx.com>
 <YP/+V90D6zyxnSyU@rric.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YP/+V90D6zyxnSyU@rric.localdomain>
X-Provags-ID: V03:K1:Qpi75xzmAtgkmrWhNS1dJD9XjDmoFDcxAxkGpQBIRTDgbDYAok7
 teoX1lFZmgl5o0oMP04MmMQo7rc5aHcjaEQmxKNb+dpJAjkUGcIZGszs+/PCM7S1RdtJS9x
 Se7Ffqb2dY3E4T5is9iD2CYbfwiihcwE1oRGpGOmj/msSfaubEpjLwnv8JOJrS53B8zR5v2
 j07pAedb8fxbj+++D0rEA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LLgS095QqEc=:xCHgX6ywc78hpi4aAqFiDj
 BbfTXbV6x6O9UZrXD8A29RLfstTg1RgkZPk3BDc+Pqboq3AYGeO0eE65puKfYJGLmObfh1uwn
 bAWRml0po5SDV099r3BtYXHSjqcjuu6tvNA4qdqIzm33MaWcq5eIySoOcDJOhR6EQDYmigsNN
 DOaeTtAjT5vdAGADXxoYiH1zWDpLi49z2XsaQZWkZd1BxeT30fLzDK006FBzZ5ZsOnrBy3594
 3hJl3WC0GbveJqJC10nejsVNYfDKKMbcldOkpQ/8pBCWTKEPO3/xKram9qqBgB/8SFFjt6PC3
 3PA4wtoBXOGeRX3NiNLopT7lYI0eNDZFPj825bRgcR1gUD36nrOdKkpvv9BdBWFfcXtzA6se0
 6Si5Kz/vFP0Hgvwp7G7Yhf0MnUkN3zwpmyYz+QE/FADAmPnYuDSgf6d8c23nDr4mvhcv4YQNO
 pff0W6HEPQyDmQaqgZ6v7kGGq6ugfGDJOnnhgZ4diCZAN89/bjVJmQhCpdYwllp5Sm38XfZ5V
 tyJuqFvz0BM/E5c2TCcDMxxtxx7SBJWsPGjszw6FvPfpYAVkg4X7re8zltEMrBmh/gW9dgAp/
 sSb5X/y/TP6cyKJlKEJFdcJeUmPmmZ+BghaBvLTpp+tNwhIPPshH8P5gOZmI/G3tUvSxfSG1C
 bVxCInOS3tFDTUjcdC0R5/I1Uqa2zC3sr/R9sDDq+Tkb6v1lQGNThyaFCygPdNPfsb4o0Htik
 dyezNn2BBToyfySORz2+BuVpWWAlEY87UpVRZzlJVTxKB0kHok+jbFIDbRv/oIQxk5/ZpjREN
 TyAz6PIWPy8tgxYh296PveuYvJQFd8E990Vxh+5cGeUKGDrtPmOUA9jZA/QowCg2STSKM2hSP
 vYO/sfVLFqzLblw7oZs1mUod1MXTt0Cp7+C6OgE2LxupQdfj149buSFegM0D4J2Eri/o1t3o/
 23yVXZTX/A3B/OhMs66RZ/eTG5q0qMv9a55zC/uk4sjwR3u5QucHsIYZ6nnoZOeelCcDRh0o6
 ymSjqjwwl0o4DTTlTEs5XJiHG9Q2hD9RIXy8ZhKdvz9SUKt2Gkx5JMIDoDHwkXf8lReF4BSpp
 UoD8Kf4iH9Qqv32eqXsMlmeBuc1mOaepUpt
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi,

On Tue, Jul 27, 2021 at 02:38:47PM +0200, Robert Richter wrote:
> On 25.07.21 18:29:54, Len Baker wrote:
> >  drivers/edac/edac_mc.c | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> > index f6d462d0be2d..1286364f0e48 100644
> > --- a/drivers/edac/edac_mc.c
> > +++ b/drivers/edac/edac_mc.c
> > @@ -1027,6 +1027,7 @@ void edac_mc_handle_error(const enum hw_event_mc=
_err_type type,
> >  {
> >  	struct dimm_info *dimm;
> >  	char *p;
> > +	size_t p_size =3D 0;
>
> I would rather use a 'left' variable which is initialized with
> sizeof(e->label) close to there p =3D e->label is.

Ok.

> >  	int row =3D -1, chan =3D -1;
> >  	int pos[EDAC_MAX_LAYERS] =3D { top_layer, mid_layer, low_layer };
> >  	int i, n_labels =3D 0;
> > @@ -1113,12 +1114,11 @@ void edac_mc_handle_error(const enum hw_event_=
mc_err_type type,
> >  			p =3D e->label;
> >  			*p =3D '\0';
> >  		} else {
> > -			if (p !=3D e->label) {
> > -				strcpy(p, OTHER_LABEL);
> > -				p +=3D strlen(OTHER_LABEL);
> > -			}
> > -			strcpy(p, dimm->label);
> > -			p +=3D strlen(p);
> > +			const char *or =3D (p !=3D e->label) ? OTHER_LABEL : "";
> > +
> > +			p_size +=3D scnprintf(p + p_size,
> > +					    sizeof(e->label) - p_size,
> > +					    "%s%s", or, dimm->label);
>
> My preference is to advance p here (and decrement 'left'). This is the
> pattern how p is used throughout the code. I also don't see a benefit
> of using scnprintf() here compared to the previous implementation.

Ok, no problem. I will send a new version more close to the original. The
scnprintf() returns the number of bytes writes to the buffer, so it is not
necessary to use the strlen() function. But if you prefer the current
pattern I will have no objection.

Regards,
Len
