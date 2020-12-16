Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8991D2DC2B7
	for <lists+linux-edac@lfdr.de>; Wed, 16 Dec 2020 16:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbgLPPHQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 16 Dec 2020 10:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbgLPPHQ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 16 Dec 2020 10:07:16 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4F1C061794
        for <linux-edac@vger.kernel.org>; Wed, 16 Dec 2020 07:06:35 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id l11so49173464lfg.0
        for <linux-edac@vger.kernel.org>; Wed, 16 Dec 2020 07:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=2WWbdZ31+sqGmpiDYQ1Pk46xJiuTDjWr8LhTHNhunos=;
        b=BrqRwbv+JYq1LrtwADqYJEr5XScVNtIw2vfbBYjtwQwPc5SEP/hdYFUeIbTns34Gch
         mYZXyTzNFzJt4thKnwSi9qXSrA6+1DPhqcrThmtuhkll/XAMfu6nZQzCRW9vKRNjFRqB
         qv8eqZ+nDhhx/Oc8aGep+fU8RuHwvNlhElrMFTZmNcADRlKUQDprU9+N7hivJh3rULhf
         niFZY6mG4qbl9j8LYCTa/pYlCjI8H8Vcndgs2dwiJhs5+CNsqAsq4tZf4PvDb12wEJYA
         hPoypmaTf9qn9A6bjpoB/K+C07YaqC4vf/JOVFkUtvaCn28k+ZNisPGUvUjlhIWZ4MUt
         45rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=2WWbdZ31+sqGmpiDYQ1Pk46xJiuTDjWr8LhTHNhunos=;
        b=ZJh04/aPXIdp1AuhWpEEtwlraZ7qZ9qjJ5voNP/uDlPJZfwL6tP7dsO1fczmh53DxU
         beR1ElYH4uylHUTHQ7jlWm4MuuPk+OhcyxdIaaf8FR94Inctx6GDLtveLF6Rth6fi205
         g/x86rhlfG+lqETPe2v6LbI0k5PAxXKKXRekxay/icTA36U4UPErMp4+hu+ITQoSk3YV
         7u5UW0Ivn/rLzxlCIbWhITuxb9shXH8Ud3Vz59TZJ+SglNiPl6qdyE3vg93owBd11Vwp
         Cpb1QR2aEFgas/3Ztm3hqhSmnvHl44iXuZ2dsqcsxB4zjx2wfP01xWNjWfqr1LsZQ5X3
         Rd7w==
X-Gm-Message-State: AOAM530WG0P4Yw1XhYi+rFetWLMXWcEFqm7o9QXuRfbC6f7qjhXULVZh
        kpqeFaAHwZzEWCBmEAgZcgkjSVxl4gSmZyc9n/fMAlp3
X-Google-Smtp-Source: ABdhPJyYv2zFDiG6IMfiLnaH6o/k/RouNrNK+Cvjt2tmtjG9RHPJQp9Ii1ukAzOavKg6UyTltNbJ9dnDpnUPlVfnfNI=
X-Received: by 2002:a2e:9296:: with SMTP id d22mr5522151ljh.197.1608131192655;
 Wed, 16 Dec 2020 07:06:32 -0800 (PST)
MIME-Version: 1.0
From:   Michael Di Domenico <mdidomenico4@gmail.com>
Date:   Wed, 16 Dec 2020 10:06:21 -0500
Message-ID: <CABOsP2O+42Kcf7F5mkzkSizTKGSG48giwkgiv3gN=KZZ+Ad+4g@mail.gmail.com>
Subject: dimm mapping
To:     linux-edac@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

is there some tool that merges the 'dmidecode -t memory' output with
'edac-util -v' to give me the mapping of my motherboard for the
labels.db file?

the only documentation i've been able to find on the net, says to
populate one dimm at a time and write down the mapping, which seems
horribly dated for 2020
