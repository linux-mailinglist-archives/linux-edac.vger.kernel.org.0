Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059DA3E39F2
	for <lists+linux-edac@lfdr.de>; Sun,  8 Aug 2021 13:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbhHHL1I (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 8 Aug 2021 07:27:08 -0400
Received: from mout.gmx.net ([212.227.15.18]:33771 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229473AbhHHL1I (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sun, 8 Aug 2021 07:27:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628421990;
        bh=KmUIUjc/SMPMYj9TExyPq3vQb0YAHTrk48Epwl7WfNw=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=NhRkGU9VqsJP5ckK4Q/2+stSYMRJGtiExrNFQnWRWUyxYSgitdl0ldpZoFWxEy60A
         8NNouudzVwlooXPudODpGhmcIGbO/i/AtYOpvyEng0BgYsjl1+na9SJW83FKJgqGC/
         JtnzOKkkKPalmPFjLvXfQOZ6RbZjCIjVfuhvklMA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from titan ([79.150.72.99]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N3siA-1nCBW92icC-00zoTX; Sun, 08
 Aug 2021 13:26:29 +0200
Date:   Sun, 8 Aug 2021 13:26:17 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Joe Perches <joe@perches.com>, Robert Richter <rric@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Len Baker <len.baker@gmx.com>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drivers/edac/edac_mc: Remove all strcpy() uses
Message-ID: <20210808112617.GA1927@titan>
References: <20210807155957.10069-1-len.baker@gmx.com>
 <ff02ffffdc130a772c01ec0edbf8d1e684b0730a.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ff02ffffdc130a772c01ec0edbf8d1e684b0730a.camel@perches.com>
X-Provags-ID: V03:K1:3hHWG/tuZZeXkjU7eXoxWLV7rDk8fAeGSgNunmZLLqyFENuj5Do
 LJRKd3uHOhBfKjaEnPLmSR+BXIXXHdzocywXWl2cLSdI+urIPqaPKKY3bHYXPlCTJOcje6R
 ZnnTHw77X6b0sg6AlRcjxNEpVmbVeCp9PpMVriGtrECQrhrB7t+uSKdly6WoG9Ic2iN80zs
 T40773XKAENZUVlxOHHnw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:mflkk1dmBT8=:wI7FHju9wMLs7LdKcggpc8
 T7Uf61/gbrpNZ09vrHUwrKFfP02yxCnHP1krx3mcnU1v1jnM0mrZM1IO+uCQQRveMbC9SoNVF
 d0kavCiT/YPfk5vDmygu+mgQbTw52T0LbMO3AxHIsXqvQL5YcIrEGjqBovZqZmGq1BA3WKqMc
 qmZ/2XWFMMFjqjWK4MIK07B2juyGJd4ARK+PYm1JVjZVvk6dv/+iGoQX+naFBfg+9kGSUknBC
 /mptbhtYwzlq5h1GjWjfNLx2f19MXlIuyLsquOUJMi4cFKVBwCujRkWhAHxS478oZGie4OUu/
 f8z4g6nInGcWBshLskkLqQ7jK0TtEwHncx0y+t4+Z1HMqA4lFl6+FXbMRQH/TVx6hdeQjswNF
 khn7O3R10VlGMXwRSWLVytCcNgVY0jK45Hz77tUbtv01gBW7aVIKJ2dubdbE4eCvXLq0JXPAc
 8Fq7sFmMUD1BcxZ3ttpRIvxvKuhtSMhy2ggGvJ+ZRPqgDqy8BBLR7l5pAhM+MDG4QWnf24SFB
 T8nkera6YXyE1We2v+wXJ6oFH2ES0zhPQnIMvbIpcRm/dbVpsy6GoPfZc+i1bZbwwQZyVlMST
 dZ8i3PZGSLSH0cX7ZY37CugMyxgYoYzzmcTROvf/BbPxmgCrl/WbjG5szjchXK9Ke91PfQUm3
 FUrV2CKW5OhhLeIiTLbbq2e9I7V4rZ2ZxiYs/EA5h9nCPPX9mE2PUzqfUrryivw9sqB/IfHyK
 HzJ2Q8TAQzEN6c3fV52nEwDihSKR5j+hh9V6eG4WfQdFf8kNY0MVQeE0ycFu/hJaJ5Hz73est
 bWczc4vnKollzNx63SL3OVM1YRw2+2BJBJUcNeQGIaPv4HBiXzzRX0zlxi3AvNIfFe3JOIhGZ
 /RRM3QsQr8PI3hV/lxBK3ioWFaM8MaTyvxYBXD64tFMsq7lxcecWEZOslVsRJU5Nk1HqFE0VE
 F9+ZeQj1n99FYCB9yXwjuE80ob5n0BGQru7gYTV7ht0oEHNamtSi+tDsHBNJv/GhsS3NuMA/m
 JkG01ZGN9AbbE6JRbNgWjSyzS6QzoeBnBC8GmkKlXZtQfzyeuIf2l6pAxO9E09cRnkMDil2xq
 dAmfuMW83CJRlURxPaufDWULDg4fte0Ig64yH0/9YCl8MB1jkFd2faoVQ==
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi,

On Sat, Aug 07, 2021 at 10:09:35AM -0700, Joe Perches wrote:
> On Sat, 2021-08-07 at 17:59 +0200, Len Baker wrote:
> > strcpy() performs no bounds checking on the destination buffer. This
> > could result in linear overflows beyond the end of the buffer, leading
> > to all kinds of misbehaviors. The safe replacement is strscpy().
>
> Probably better to change the commit subject to something like
> what is generally used by the subsystem.
>
> Maybe:
> 	EDAC/mc: Convert strcpy to strscpy
> or
> 	EDAC/mc: Prefer strscpy over strcpy

Ok, no problem. I like the second one.

> and also:
>
> > diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> []
> > @@ -1113,11 +1115,11 @@ void edac_mc_handle_error(const enum hw_event_=
mc_err_type type,
> > =A0			p =3D e->label;
> > =A0			*p =3D '\0';
> > =A0		} else {
> > -			if (p !=3D e->label) {
> > -				strcpy(p, OTHER_LABEL);
> > -				p +=3D strlen(OTHER_LABEL);
> > -			}
> > -			strcpy(p, dimm->label);
> > +			const char *text =3D (p !=3D e->label) ? OTHER_LABEL :
> > +				dimm->label;
> > +
> > +			strscpy(p, text, len);
> > +			len -=3D strlen(p);
> > =A0			p +=3D strlen(p);
>
> Perhaps this should use scnprintf rather than strscpy
> Something like:
> 			n +=3D scnprintf(buf + n, len - n, "%s",
> 				       p =3D=3D e->label ? dim->label : OTHER_LABEL);
>
In the first version [1] the scnprintf was used but Robert Richter don't
see any benefit compared with the current implementation.

[1] https://lore.kernel.org/linux-hardening/20210725162954.9861-1-len.bake=
r@gmx.com/

Regards,
Len
