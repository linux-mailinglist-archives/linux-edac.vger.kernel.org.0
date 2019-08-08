Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B36E986586
	for <lists+linux-edac@lfdr.de>; Thu,  8 Aug 2019 17:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732477AbfHHPTE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 8 Aug 2019 11:19:04 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:43676 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389876AbfHHPTD (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 8 Aug 2019 11:19:03 -0400
Received: from mr2.cc.vt.edu (mr2.cc.vt.edu [IPv6:2607:b400:92:8400:0:90:e077:bf22])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x78FJ2N5001435
        for <linux-edac@vger.kernel.org>; Thu, 8 Aug 2019 11:19:02 -0400
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x78FIv3v010264
        for <linux-edac@vger.kernel.org>; Thu, 8 Aug 2019 11:19:02 -0400
Received: by mail-qk1-f200.google.com with SMTP id e18so82640760qkl.17
        for <linux-edac@vger.kernel.org>; Thu, 08 Aug 2019 08:19:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=Mz5YNJGQLxkAt1Yp0XvNK2J5Q+Yh19UsVBE0iVAb2wk=;
        b=KjkLPM1wPO4R/QgF3DpdwiCwP7AmduGac3KAry5/Mxk1KjS9C6Bm6STDwTTSlTO4YL
         VHydk+1pdBnCXnokGMnvXfHaBfokfnOc7sUrBCw/Mm56kc2/+PQ5Smhab1lkZwUhCUsC
         HB2DGxDTtJt7Z2ecOFNczG5DTrTCmDPZZvnowSmmGYg9XFcdN8DkB0pcF25GIosGqhNP
         YbnADIi2pkKm5I8XSMQzyJ97n0sgPEZQStU1YmU6gJvVzjv+WokGN59UDPUXUM/AvoiP
         KeGGMh+l7q+LsLmQiU23Smgn0wwnx/ymZQRMaY0pjrr+hj18vdWttABkFneBZPj8xM32
         qXuQ==
X-Gm-Message-State: APjAAAV2InV6w+7Qd8EdHETBcC4VRdUewf0jGN9ZERO4RxQfmg3Wesd/
        voL42ohtN6t6zrcMbZGh8c69yRcCHsvVJZq3xpVbtP4pwb0KF8Zp5UEP414Nu/CUbHtg6MtK8cJ
        OMmabBb63liO7dJi6oroM9fERE02TrAQj
X-Received: by 2002:a0c:8695:: with SMTP id 21mr14060203qvf.166.1565277537060;
        Thu, 08 Aug 2019 08:18:57 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyVymH+HfDH06bY7DUoeXncYML+uxbN0G23FiFMn5CfIw4hXYiB6nmgG9Lap7VwuF9DPccieA==
X-Received: by 2002:a0c:8695:: with SMTP id 21mr14060187qvf.166.1565277536837;
        Thu, 08 Aug 2019 08:18:56 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::359])
        by smtp.gmail.com with ESMTPSA id m5sm420174qtc.89.2019.08.08.08.18.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 08:18:55 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] drivers/ras: Don't build debugfs.o if no debugfs in config
In-Reply-To: <20190808151415.GH20745@zn.tnic>
References: <7053.1565218556@turing-police> <20190808093101.GE20745@zn.tnic> <77171.1565269299@turing-police> <20190808142055.GF20745@zn.tnic> <84877.1565276929@turing-police>
 <20190808151415.GH20745@zn.tnic>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1565277534_4269P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Thu, 08 Aug 2019 11:18:54 -0400
Message-ID: <85385.1565277534@turing-police>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

--==_Exmh_1565277534_4269P
Content-Type: text/plain; charset=us-ascii

On Thu, 08 Aug 2019 17:14:15 +0200, Borislav Petkov said:

> I'm build-testing a slightly different version of yours and I'll commit
> it if it passes the build smoke tests:

> -obj-$(CONFIG_RAS)	+= ras.o debugfs.o
> +obj-$(CONFIG_RAS)	+= ras.o
> +obj-$(CONFIG_DEBUG_FS)	+= debugfs.o

OK. We'll do it that way then :)

--==_Exmh_1565277534_4269P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXUw9XQdmEQWDXROgAQKiLw/+N03ybWysPxHxlu+rJ250KrzIediZ0S9O
ui1T3VeGQkbrt+nyVm/1KM89jI+T2g0fAPDYP3cQBobr0pEvikl4loD8NTg5Vrtk
WaT9AfQov16DX/rvNmvDqVQSMwZNB7tR6tuLPMqQFQltRMEtr4wdltGABSaAQneB
DSPtIj1LlEgwq42H/3T+6reJKHy/Qh7VJYshRWuW+BBiYpafXGkjSfEkVRqVW9rm
p2P8QFqGwNa6X0Us1LTGC5PL4xpkYhel5RbEBUhAgM+AR5Dx1dsgh5/sn9wIwTNV
I3q+OjwjmMPewbeu5em4xhcNJTwodJcfYG2tn3iZQryCGX1LnDWUGEXW6luVUxz6
IaoO0ZM9LK36X1ir72WG05wjGSmBnIJ97soE438HnuHqxQgfzAVaSDjr/EzmKKKj
KD021eyUam6gn2Gr9eGlDVFzJff8tT5gz94vjNS7Jz2/1OCI9G5g4Z3gR1nHJtdH
cj4iyUHmhzGAK03Jz4S2lP9AB1AFb1ngb9VVIMDAekz3SzhmjTffKeHX7oX3G/w5
tTxXCla4+uKuPRgBHGeEY6AzWRvHdFP/KKAr+hTrXixBJE+7ztoIRRIND7NXWUOe
Auo3YAbmj2L6+q8caVC1XsQAt+QvWBAPV1fscogJkP/h3JFh8qNBUrLLN8jy9K91
t8mM73k+lrA=
=n3at
-----END PGP SIGNATURE-----

--==_Exmh_1565277534_4269P--
