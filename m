Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F34F53F5C20
	for <lists+linux-edac@lfdr.de>; Tue, 24 Aug 2021 12:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236432AbhHXK3U (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 24 Aug 2021 06:29:20 -0400
Received: from mout.gmx.net ([212.227.15.15]:42571 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236287AbhHXK3R (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 24 Aug 2021 06:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629800901;
        bh=xHXTAtxJwor1LG2/qAtn0Wqt7cDisvqT4g+MjbeAtXc=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=To51Zp9DrKsF5GsKTkU/NlrMj6ZrboyQVNrODLmq+Dd1djmomwEckuRLoAzsKfGki
         M9n5CBRFiG3C50xRMvpc304L77iQ0S5l8vPOW6J2x0o8wTK+2OwEnPVhpDlb/yArZI
         sIasjjAmXHy4+filN0Kag7fmPB3ARWWEy6+CveyE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from titan ([79.150.72.99]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mo6qv-1mqCrv33Fb-00paBd; Tue, 24
 Aug 2021 12:28:20 +0200
Date:   Tue, 24 Aug 2021 12:28:07 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Len Baker <len.baker@gmx.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Joe Perches <joe@perches.com>,
        David Laight <David.Laight@aculab.com>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] EDAC/mc: Prefer strscpy over strcpy
Message-ID: <20210824090338.GB7999@titan>
References: <20210814075527.5999-1-len.baker@gmx.com>
 <YSPbOo90alPsv4vL@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSPbOo90alPsv4vL@zn.tnic>
X-Provags-ID: V03:K1:Oo33x5FhSFeBtYwnQ7Ylzm+sjaifw/tIrxeZRwFOY/hqIuw+Rj8
 e1uCJJJ7M9qF06tsIkAQSvm9q9fwTujJClCYoAymNjIwAg5F4naAdpZ5nC/0n/n+Opf7GJe
 Y7W68GiwTPzzh8CLVa5IDqFztBXznnBS2d0Xfzfo76yLophwjYaXBeYwMsFXIjgDXopN8kn
 AOnImOuSYESfyevdHaxNw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:89artnYeouA=:zVRuAlB+2MprQnsxXqk/YF
 dGME5J9+DOqEpNOla9x1ww85trdpHF0HyCFOfc4ebVAV4NXft1pC1Q/4tgypeZiu95bqhk6L5
 WyXQ6v7qcCd1f5e+M8+yfX0jPuC7DzyKCJLSZ2m6WSH6ZGCu8ACw2W+mY2lqqqRpPca7nCc19
 Q9xTiS10sUfmOVC8MklqtqL5Qyh6lg3yi+WuPtMtDjkKJYlWQeWMN92dZ/JuITZve4uBB31ys
 g0ejUQn/I9h5dUue2YpGK38HWzW56x5MgG+y3Fo6kNZtXtMlMvd5IKVCczB46ETKVTY7n4Xug
 uXqM9rDRhUNNPVDF8+bkj8E6nghcwNuAe2PTIsig8twoa5aREz3hph5+6LW0nZ2o/5Er9SJvp
 M3t9Yl1i+02MPsBDd+aO7K/+Tmc/RTyI7n+BNSWY0AJDV40q4miPomCNNZj4mWdPJMJiy3Z8C
 41BASntzgDfBp+tqLwP7wRUnPZgBvtf/MQFEAkWgs3+YgXk+h+sr9+VyXvPU3+wQ5XZMs556l
 dzeC9p6dDk1dvl5FV1m+oBgvwW/4B4eaZL4fpFFZHSkACCGa6Qe4lfdkdpGO8W65msL0CA9q6
 CTf3EL7uaXGTfVVJkp1M2dy3CKAmg0Gv65Zm+kvjlRb0e1hyPOuVHr52MmCnVlnAuzhzHTviV
 m/Jgc5EGhydiabL5rtr1dqk7SQIl2IlYngTYyLt7qt3RKM9mQdbimTdwGOhThQirdz0+TlyGc
 QO+V39iXrOakfowE3jEKusNlEDo64t/UMHiuy/AatTfpWULr709iUthKzwfBDf2gLSMWwgeKX
 kXoLwOOxgTF02xmKQKZ+J/7Bc+2B/y/FVyoBSacN7O+Kgi8+v5SR3T/d2l/pqmCTzPLHD1mr/
 Vs6e/Wzz9II+KdMe7/XQtKdjfHJyzDf76wuR3HXrUYOyI3E6rwUy+TSxuxYltuvufIcP/Lrio
 UevO3So6lcvPA7noygrVKeUny9fc3KFRT34IDPjX/6aQw4hR+RMYLuo2j9VvqM+Q40Ips3Q7W
 KVgpO2L5IghZ9R9UqKuj8molHbFPrvvRIVeYbSPEyuwX20w/Xj7K8vPSnEfIt2RWlrQwhYsdY
 Jl5acINF0MV59SwD5LYaDrCJU9ljj7QoOT0tpEx+FTa1gdNU8O0WshaIQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Borislav,

On Mon, Aug 23, 2021 at 07:30:34PM +0200, Borislav Petkov wrote:
> On Sat, Aug 14, 2021 at 09:55:27AM +0200, Len Baker wrote:
> > strcpy() performs no bounds checking on the destination buffer. This
> > could result in linear overflows beyond the end of the buffer, leading
> > to all kinds of misbehaviors. The safe replacement is strscpy().
> >
> > This is a previous step in the path to remove the strcpy() function
>
> "previous step"?

This is a task of the KSPP [1] and the main reason is to clean up the
proliferation of str*cpy functions in the kernel.

[1] https://github.com/KSPP/linux/issues/88

> > entirely from the kernel.
> >
> > Signed-off-by: Len Baker <len.baker@gmx.com>
>
> ...
>
> > diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> > index f6d462d0be2d..7aea6c502316 100644
> > --- a/drivers/edac/edac_mc.c
> > +++ b/drivers/edac/edac_mc.c
> > @@ -1032,6 +1032,7 @@ void edac_mc_handle_error(const enum hw_event_mc=
_err_type type,
> >  	int i, n_labels =3D 0;
> >  	struct edac_raw_error_desc *e =3D &mci->error_desc;
> >  	bool any_memory =3D true;
> > +	size_t len;
> >
> >  	edac_dbg(3, "MC%d\n", mci->mc_idx);
> >
> > @@ -1086,6 +1087,7 @@ void edac_mc_handle_error(const enum hw_event_mc=
_err_type type,
> >  	 */
> >  	p =3D e->label;
> >  	*p =3D '\0';
> > +	len =3D sizeof(e->label);
> >
> >  	mci_for_each_dimm(mci, dimm) {
> >  		if (top_layer >=3D 0 && top_layer !=3D dimm->location[0])
> > @@ -1114,10 +1116,12 @@ void edac_mc_handle_error(const enum hw_event_=
mc_err_type type,
> >  			*p =3D '\0';
> >  		} else {
> >  			if (p !=3D e->label) {
> > -				strcpy(p, OTHER_LABEL);
> > -				p +=3D strlen(OTHER_LABEL);
> > +				strscpy(p, OTHER_LABEL, len);
>
> Hm, maybe I'm missing something but looking at that strscpy()
> definition, why aren't you doing:
>
> 				num =3D strscpy(p, OTHER_LABEL, len);
> 				if (num < 0)
> 					/* just in case */
> 					break;
>
> 				len -=3D num;
> 				p   +=3D num;
>
> since that function supposedly returns the number of chars copied.

Yes, you are right. The same discussion happened in the v3 review [2] and
I agree with the reasons that Robert Richter exposed. Using the strlen()
implementation it is not necessary to check the return code of strcpy and
we can assume a silent truncation.

[2] https://lore.kernel.org/linux-hardening/YRN+8u59lJ6MWsOL@rric.localdom=
ain/

Regards,
Len

> > +				len -=3D strlen(p);
> > +				p +=3D strlen(p);
> >  			}
> > -			strcpy(p, dimm->label);
> > +			strscpy(p, dimm->label, len);
> > +			len -=3D strlen(p);
> >  			p +=3D strlen(p);
>
> Ditto.
>
> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
