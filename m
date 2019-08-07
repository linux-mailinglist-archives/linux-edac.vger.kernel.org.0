Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0A2A85635
	for <lists+linux-edac@lfdr.de>; Thu,  8 Aug 2019 00:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730280AbfHGWvt (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 7 Aug 2019 18:51:49 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:50576 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729753AbfHGWvt (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 7 Aug 2019 18:51:49 -0400
Received: from mr3.cc.vt.edu (mr3.cc.ipv6.vt.edu [IPv6:2607:b400:92:8500:0:7f:b804:6b0a])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x77Mplie012336
        for <linux-edac@vger.kernel.org>; Wed, 7 Aug 2019 18:51:47 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        by mr3.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x77MpgH9014682
        for <linux-edac@vger.kernel.org>; Wed, 7 Aug 2019 18:51:47 -0400
Received: by mail-qk1-f197.google.com with SMTP id x17so80717638qkf.14
        for <linux-edac@vger.kernel.org>; Wed, 07 Aug 2019 15:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=VVqj1RHavfLwN3oDC8GBFJV2upV3A569CWoZr0FMSAI=;
        b=PuX4hU3Wce+hhk3F6Zt9fqjbTo18upcAA83yzN3SmXBQJRb50LkG1KlIxk5Q3+1XVl
         pUXHLjkal9yao26CDq77DpAHL0VU29Y99blWEHoTMMNwio4Yxz9v6t+1LPptqHcsy9Lr
         ig+ogQIgs2VEgH8kGBrJBYMXfstciIjqtaNekfNOWtI5PRnz7QJGXa5Bgi9Dmko+20ul
         lKuYCcbUUZVfhiq0t7R3GIEkGzFMr9DWIKnNWLorDC8Qir5BiHG6Oe4rd5wSiNiN/mke
         BS1XNrNdYAdHZ0jpjnzbXTyOsDkcEH6xQhHw/GtdXNVB93JN4mRdmGMYBU3iFMyJUXmK
         cfpA==
X-Gm-Message-State: APjAAAV9jlIX15iJyHeovDrn6kMrgEGZ56EeGmD5O8vYsHItDj09AlBW
        KimL3m5Z1wfNCW82xxaNPVMeQ3hjcyWUGKhjQ5c+u44QruHKBNGU3MsYyFre+/2cQEjdSs0wnNf
        Ho2eU/UHO+loklyHWXCqgwuaGw6GLpOXI
X-Received: by 2002:ac8:194f:: with SMTP id g15mr10459995qtk.113.1565218302719;
        Wed, 07 Aug 2019 15:51:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxFVSty23dhumB7bRuWQr1litmwZOB8e2hPR6QLdBsmY9Fdo6u3y1IL1k670uNq+n9spIELcg==
X-Received: by 2002:ac8:194f:: with SMTP id g15mr10459984qtk.113.1565218302520;
        Wed, 07 Aug 2019 15:51:42 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::359])
        by smtp.gmail.com with ESMTPSA id u15sm1920864qtq.76.2019.08.07.15.51.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 15:51:41 -0700 (PDT)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] drivers/ras cleanups
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Wed, 07 Aug 2019 18:51:40 -0400
Message-ID: <6559.1565218300@turing-police>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Two patches in this series.

1) There's no need to even build drivers/ras/debugfs.o if config doesn't
include debugfs

2) Add proper includes to silence warnings building debugfs.o 

Changes since first version: deal with error when building without debugfs.

 Makefile  |    5 ++++-
 debugfs.c |    2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
