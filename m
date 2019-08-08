Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63ACC86282
	for <lists+linux-edac@lfdr.de>; Thu,  8 Aug 2019 15:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732876AbfHHNBt (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 8 Aug 2019 09:01:49 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:37708 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732375AbfHHNBt (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 8 Aug 2019 09:01:49 -0400
Received: from mr6.cc.vt.edu (mr6.cc.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x78D1lVt026891
        for <linux-edac@vger.kernel.org>; Thu, 8 Aug 2019 09:01:47 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x78D1gpa020059
        for <linux-edac@vger.kernel.org>; Thu, 8 Aug 2019 09:01:47 -0400
Received: by mail-qt1-f200.google.com with SMTP id l16so78634236qtq.16
        for <linux-edac@vger.kernel.org>; Thu, 08 Aug 2019 06:01:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=4jDm1LJxN1RESruaeejG2ahlir0jL/pa+aKRSCL3YxQ=;
        b=gpSPm5Pdmt897ydohMajvqIXIj+qM3WnV/gqMBoxNSnHwCSB0UxkNuhEcNxYHRGI9z
         JkFLXrCL5ioL3wZz6Zyz0H8o84/O+8GzOp+RDp57u4B6ZpOB4NUHGweQcFy+6M+HTtdf
         FNIAW5+GoT8JvW/jllrGOrKIEP/Fa+AZaWu/tn3dJvqiYk7S4SPCk9Dr4ke/Dxukg93Q
         xsyGJozFgpi7W38n0sxcROtveODFom8iLpS/sc0zqoeCQ9dw7NRZbcXqErVY6w2pl7Gl
         DM/dswKkyWW5YBy0dskfotqI3+pv6EaO26qAfE+hjs+pMezc8HTM/LisMgD5rp+4r1s/
         kxIA==
X-Gm-Message-State: APjAAAWpx5bZVvhZBF+QYVWWoIy8VaIITwGQspI6N4gQMTuRtL+gXp4Z
        73Mlur4l6TcmA+DQfjISvr1cEzqd+xro2Ty22VmZlgITrdez9JenTLd5SgjOqHQbA6rbQgiKmLF
        x05fgeJkPW15lZJChHkjKQUGSUivQunWk
X-Received: by 2002:ac8:759a:: with SMTP id s26mr12753554qtq.81.1565269302312;
        Thu, 08 Aug 2019 06:01:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzc8scp7b3x5ucWe4a7eB+T9gH11G/hM6MUNN365YyDztuKHT07lKRNm+bX8pSihmI5PayLfw==
X-Received: by 2002:ac8:759a:: with SMTP id s26mr12753517qtq.81.1565269301967;
        Thu, 08 Aug 2019 06:01:41 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::359])
        by smtp.gmail.com with ESMTPSA id f22sm356979qkh.55.2019.08.08.06.01.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 06:01:40 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] drivers/ras: Don't build debugfs.o if no debugfs in config
In-Reply-To: <20190808093101.GE20745@zn.tnic>
References: <7053.1565218556@turing-police>
 <20190808093101.GE20745@zn.tnic>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1565269299_4269P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Thu, 08 Aug 2019 09:01:39 -0400
Message-ID: <77171.1565269299@turing-police>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

--==_Exmh_1565269299_4269P
Content-Type: text/plain; charset=us-ascii

On Thu, 08 Aug 2019 11:31:01 +0200, Borislav Petkov said:
> > There's no reason to build the debugfs.o if the kernel config doesn't
> > even include CONFIG_DEBUG_FS
> >
> > Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
> >
> > diff --git a/drivers/ras/Makefile b/drivers/ras/Makefile
> > index ef6777e14d3d..07a5c391cc23 100644
> > --- a/drivers/ras/Makefile
> > +++ b/drivers/ras/Makefile
> > @@ -1,3 +1,6 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> > -obj-$(CONFIG_RAS)	+= ras.o debugfs.o
> > +obj-$(CONFIG_RAS)	+= ras.o
> > +ifeq ($(CONFIG_DEBUG_FS),y)
> > +obj-$(CONFIG_RAS)	+= debugfs.o
> > +endif
> >  obj-$(CONFIG_RAS_CEC)	+= cec.o
>
> If this is not causing real trouble then I'd prefer to keep it this way
> because ras.c is pretty useless without the debugfs functionality.

It's needed if somebody applies the patch 2/2 - and I just got a note from
the kbuild test robot saying that happened....

And if it's that useless, maybe *more* needs to be done to ensure that
debugfs is enabled if ras is being built - possibly a Kconfig 'select' or something....


--==_Exmh_1565269299_4269P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXUwdMgdmEQWDXROgAQJcCw/+M4y+WfSXNXNTyGUgLjHKAL6M3ymMp5x7
/dYoTpgvZVzMPE7BK/YltBZfNvVnIuH1BXhcBwZFfmv0ZldGH4pGF/8d258JsD/+
IIPhV1YscwXHsiPKvCG6QjZlWUJ0Gb4aMLdWskSIAacgpz19uHifEaXPGkuRJIm4
nyIF/KklbZ/RHBDsodCLs1ialvwyt+EOmT49L89T2qwDKqwA6Y8QwxbZ7gOdhnqZ
TBMYdxCjXNa7UVtpHf6n89Qwe60spMKUex/QQ6aZE0HIprRVnc9XcdPsy8YfHRAZ
m/jOs8E2GVP6ixlzCCn/c2EOphaLvu2u3BElyyBdQnylb7K6pghQdE60g/OE7SWP
zCmV4ppXdiAe7JqdIALtN57FTygTdVUHVY8oBzkmJfIXWJYz+vTkzlf9Q6/ITcQ8
9vvqb9FQ1QoczQeVyGl7sN6Lu1NtX/wtIv/C/XkK9THotIuF3Bf7VNIZctwTO06g
89AwD5vtqcSOQVTNnA7dbJ5qOlzXJwAuC4pStEOFPWN8kpuOFL0ptHP8/523ymYq
GihSgWHpfN539AJ4FRvHbF9MUwD04H9Q9ecCqwem/lTvdSS59UPYwc7wsp5ojXWN
LuXOYbcRnwKCjrxbbGD+s5pk8mdfPZC33WOIa5Ugd3gUDZtRvTeiUTToT5eaZUUV
6LIXZLIB/0k=
=YiPP
-----END PGP SIGNATURE-----

--==_Exmh_1565269299_4269P--
