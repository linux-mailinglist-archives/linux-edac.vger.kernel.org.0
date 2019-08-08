Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B37AB86527
	for <lists+linux-edac@lfdr.de>; Thu,  8 Aug 2019 17:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732297AbfHHPI7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 8 Aug 2019 11:08:59 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:41000 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728327AbfHHPI7 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 8 Aug 2019 11:08:59 -0400
Received: from mr4.cc.vt.edu (mail.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x78F8vmH030140
        for <linux-edac@vger.kernel.org>; Thu, 8 Aug 2019 11:08:57 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x78F8qvp026245
        for <linux-edac@vger.kernel.org>; Thu, 8 Aug 2019 11:08:57 -0400
Received: by mail-qk1-f198.google.com with SMTP id j81so82432494qke.23
        for <linux-edac@vger.kernel.org>; Thu, 08 Aug 2019 08:08:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=sZG45UfQMhTHDUgEHKrzSwCRO/ejJ3aFWUQpSgQlypU=;
        b=XVJy1qnO71xBtZ2GFAfVFXRNY29TPAWnl39WCcQfVOei5w/W5MqIw5r/PJ4nsP8soQ
         AIEBIygCrHjznusJQh6gmaxpW6/CjluHWJWNfXiHTxfqeAa+wE185qdFJjEsJvZpdZ15
         L6h00njZxQWCwyppPMShbs9mWexYzX+9MiS1DC0AZYjqiTOUcq+Hj0BcloYk8lAhOo7R
         xGCupjUSSykGjxPBrYOMpykLiHvEcYh+rZ9vr0aOzV2KVVuR/m7BOV39hQzb3wk3pnSd
         rxHIqk9+CdtQFlOFyYhVl/UYHBjoD+DBfS1HbKUEu+47wquWsP0be4bkgYVkcimyYsv5
         LVrg==
X-Gm-Message-State: APjAAAWCvwz/V4luijK4fEvtzDLJs6utZ2d1ing6TPEW+3IjdJdvfRQe
        GmjuWXvx1EvvlyHFPY70l/AJsrxkfKNLNdVR5c7bbJrEJaTCOyI/N4LNa30gWZjSJj+fBD2KfzQ
        VDw17/SqGuIWA9r0131L1s8CvWUYGcV7B
X-Received: by 2002:ae9:eb08:: with SMTP id b8mr9196295qkg.481.1565276932460;
        Thu, 08 Aug 2019 08:08:52 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyA4TmeX8wFs2niCTUr8jpeybcDjuWJjkUN+7g+sMgPRJHkHu8c64Y0d9aeO1jbLAwwx41VNg==
X-Received: by 2002:ae9:eb08:: with SMTP id b8mr9196266qkg.481.1565276932155;
        Thu, 08 Aug 2019 08:08:52 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::359])
        by smtp.gmail.com with ESMTPSA id r14sm43822769qke.47.2019.08.08.08.08.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 08:08:50 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] drivers/ras: Don't build debugfs.o if no debugfs in config
In-Reply-To: <20190808142055.GF20745@zn.tnic>
References: <7053.1565218556@turing-police> <20190808093101.GE20745@zn.tnic> <77171.1565269299@turing-police>
 <20190808142055.GF20745@zn.tnic>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1565276929_4269P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Thu, 08 Aug 2019 11:08:49 -0400
Message-ID: <84877.1565276929@turing-police>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

--==_Exmh_1565276929_4269P
Content-Type: text/plain; charset=us-ascii

On Thu, 08 Aug 2019 16:20:55 +0200, Borislav Petkov said:
> config RAS_CEC
>         depends on X86_MCE && MEMORY_FAILURE && DEBUG_FS
> 						^^^^^^^^

I'm willing to respin that patch that way instead - if cec.c is basically
pointless without debugfs, that's probably a good solution. My first read
of the code was that the debugfs support was "additional optional" code,
not "this is pointless without it" code.

--==_Exmh_1565276929_4269P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXUw7AQdmEQWDXROgAQKNRg/+KNGYFpbwNYNSUS145bUcs6vMvWaQtaao
qWy9xgA3sFeykg6JDreq0viGTyIL/Sr3GHn2XR2Y96d58bOWZZs4o+uDfbjIEdO4
lQ6qZPOo0gPKMYv04xTyyG8XTFXBCN/JgUQP5zGEapXVasd+IdmDJI3/ITfjx+TF
+k15Ytf0sUGvR/RXaFnautbmcWkSlhKwkCluoo1+6S2As0IgalBCD4R2dx/1W1By
wclZ+M2f+b4HS3qZC7u/VmLBy7pU6CFJ4aU3zCoc/bKc5lfRWf7xkNwG7DMUVnOV
QLtDPa9bdMGX7s3HgTf1h4qXM81i6Gy6stjRoyE1CEI5VKO3EnyIycaje5xknEF7
OAOxqKjgEYi06xlBoWjmMxjVfFUd+nqY61S0PoHPscvmWVJ6p8JkUb4G27tXK21l
QxExAtX2f8YEYsv0Zjrrq0upXjHcOoiaVuVl9gv6bDaUZgfQ60/hT/78JNSVOv+g
IRlq4egBQaeF2TrIuAwEoPWlnG6kOfLKuI1hIduKuHVKIcxNk6dmtPt5wO740O98
8uF9nMivwqBwICkSPWPhAIOdCwSMh4HjhHkNd5xrQ5ZB8+woLy9nW76EdTFk2LUv
vd9APOV9WNy6BmasFL3ojgYp1nz3tHTcfUQ6ADA/4so69dx7NPAa5FW4JoFTc2x0
Is22wr5pjoQ=
=ntaN
-----END PGP SIGNATURE-----

--==_Exmh_1565276929_4269P--
