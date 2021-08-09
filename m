Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0854B3E49C8
	for <lists+linux-edac@lfdr.de>; Mon,  9 Aug 2021 18:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbhHIQ0m (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 9 Aug 2021 12:26:42 -0400
Received: from mout.gmx.net ([212.227.17.22]:43689 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232881AbhHIQ0Z (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 9 Aug 2021 12:26:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628526343;
        bh=3nL4/VMzAAvkcx/Y4QlFv5TCFLlPZza+oU/Wlor7F0I=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=fd6T0XFTVs5g11Oy5tuiZ8D+w2Fqyx0qc0G+KYdp6bZXiKZaynOK2zqewkIjJuZWs
         RLPoHo1J7kaWF0uztR5NtyYInX9qkr6aidHu8K5mfLeRzF5bCvGoIjME8WcTRJ85Qx
         o5WplG4Qwvz1mwNWZ0VATwOtcimF+SrCeD0BTQzQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from titan ([79.150.72.99]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N9dsb-1n9ETD3FS9-015com; Mon, 09
 Aug 2021 18:25:42 +0200
Date:   Mon, 9 Aug 2021 18:25:39 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Robert Richter <rric@kernel.org>
Cc:     Len Baker <len.baker@gmx.com>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drivers/edac/edac_mc: Remove all strcpy() uses
Message-ID: <20210809162539.GB2619@titan>
References: <20210807155957.10069-1-len.baker@gmx.com>
 <YRD6uoVYwCSFN0U0@rric.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRD6uoVYwCSFN0U0@rric.localdomain>
X-Provags-ID: V03:K1:tUFOpibvDcC8BQZoy6rQw+BXUlHzBlNyJwMXnOpXUnskVAlpSTz
 nh3dHIazEuUS6bNCCMtYrpcmrmeR1lRQ33I61RWuN9v6UOxdRtxX3V7rZUhP8+KUUa4yb7W
 ZUkIDS/H9oWKgqvjXm2x+y4GYppZ43OX4cqsMl+WZY3/0+zjoRZ5oi3y96W2GZlCvsRiEBw
 4ov5U+xfhsnIEjvyxVQtw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RvyGGdQcpwE=:nPhhZFPAwQOPWW+hbdauA5
 dCVp/TofLGNswLYrURJtbshoSRiZZ+VtjaqE+LF4xLWw8f4NfhdVcUsZxezGyXuYaP5OAtFF8
 cTCPcFHRyj0BzLER8Bsym4jtp67c2k6Sm9kTdmEi6kDLS4qIy5Q5y6equ97W/obfR4XRobFti
 bqzj4UghltdqSYSQJmvKkm/COTXCnUGgbJLICUokqHF9fVUoUfSZiWwoW10PB+kfxlYNKdAs7
 va6pwjVardNYasteTOLar7YCf7zi9ahOQgwED3iK3tX/sE56jK/cV7DdTIfogZFkFjVx8BnTI
 jeG3dNMTDtSmaJ+gjS5Ra74WsvZBFDPuBwhDc+mhxT553Kf+0hLtLYWlUPpex4gu7OQL3BnG6
 9tzz9JhkFQOSm2zFHH0PMKzjzMYXYA4NKcMwJvXngXVD42J5erTOzlN8waUnap2KosLPWCx+u
 yRM4abt42bcTrvMNG0G/k3ukjUm09v52kfsBpY7rZ5lFESSbsUAqRfJ5gv+Tcq2UkFPqSMJxB
 98WwUpK6NVMZKDh6jfxEMBT8v2b43N8nyqB3k7njCDZRkjt7787coXTHV1FkDp3CRnREL4yah
 n6N0QmeYyaye9ANzrMrFmI5LtmqtlMmfsMlkPsl6K0tgR4NhfMnS+dRaWao6fJkcCWnfgqy7i
 4QTkkywBlooihzDWeVJJKwWoFd2JBEmvYoLUMP0OYsOLGL4e7gODhamH6kvre52Q7F+0YCMfD
 KN+plqORD3tp5g8FxvP81VGujdr3C4CJegUrkY5vP3Jrg2zXYq3PIiJOubT/xIlgy0l9eSisM
 fN/s64KN42v/kttOAtQANB2acAo7xft8NaXEGIkL+fJrwNQ1EFQ2ggWrysnHICWcUkKtsoLrF
 SdnPOv4iREsHlpDOcfNa4ZxmVwj1EAs8jlCN2cOwJ0SjF+5xHW+Y1KRfyQ85XBK9JAPxT9TTH
 MGmIo5N8Ar1IVUFb2L/It6qVm+bTjexe57rx7pNjDF1z+ENPfqOYMnehbJ6exExz5NQ6M+ve6
 jpqJG/xewEx/7F5QcqFvZItfi4du3BRuSeknQ+lwMh6ZQkSp1FgxbdVqqRICBWQnb5cI5O+Gy
 p1pz6vOal4xeMzXzqSmKQZJ4rW2rZQj6wY4mIVrapaBLPTki6jTPLRoiw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi,

On Mon, Aug 09, 2021 at 11:51:54AM +0200, Robert Richter wrote:
> On 07.08.21 17:59:57, Len Baker wrote:
>
> > @@ -1113,11 +1115,11 @@ void edac_mc_handle_error(const enum hw_event_=
mc_err_type type,
> >  			p =3D e->label;
> >  			*p =3D '\0';
> >  		} else {
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
>
> The logic looks broken and dimm labels are not properly copied (the
> code should add an " or " separator between labels).

Apologies. My bad.

Regards,
Len

>
> >  			p +=3D strlen(p);
> >  		}
> >
