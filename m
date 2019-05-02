Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C30AF11810
	for <lists+linux-edac@lfdr.de>; Thu,  2 May 2019 13:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfEBLQ0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 2 May 2019 07:16:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40050 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfEBLQ0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 2 May 2019 07:16:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id u17so949129pfn.7
        for <linux-edac@vger.kernel.org>; Thu, 02 May 2019 04:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=R5swJlAITju8XH6qDqL0ICBlF1jL9P7SgWpPio7VZHA=;
        b=NYaCI5Lq9sbeex/Hyus53942eETnhAANEybb8Pav+qTxn2QwpygQeTPQ9ijMngIIVi
         MWZiQ9OR8+52nfEJCJRnWdf87muqgNpsbqZvPlnXLqdiiiXCMSpt5B+lKRIjZk+5FaB4
         psDwFfwr0qko0Vnjf/Pd5jZN6gLFz5spWZSgGIUXXzqqqj7XRKCqmJsrRjy1jGh+5Yik
         PIXix3jtrxsLXwyvzF21dFbVZWnYX66hs5XJMJRZk7AQEAR3pOGPhxtrSvqawt7xInuM
         pVuPXRpetMck8s8L238K0ZaonxcR4gKcebzDnVn5wDtJC/54sgWBu7Q4m92mcw9zNfF+
         RLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=R5swJlAITju8XH6qDqL0ICBlF1jL9P7SgWpPio7VZHA=;
        b=YxwYJcY65b9v3LuvKqUf15ImVkzuij01Lu0dh84CQGK0IY+IPtXfAuTPz+GtFLzBww
         VL11EJPPSh1MAwsHawoF4fTtSeGj1LLvqfnxbxlMHxVVYGkq8agk4rkViM2N84ebup7V
         v/xNBzxAGTLc8EPYNcx+k1HmiZeJeEKrpaxHPeUzYP2ijNcfF3FqnUrsKk98OGqcZFjK
         qEX2MuktdMWgoNibXWlltWuEOLk24MhDN/VzmDJ+mb0GGuG5Lw7tm5jJGTtqe5YLOJPO
         Z5JYcP7igIDj34NRfMFOHMO2igjffOmS3fevnPvmhrtAp7IJm8OuklBPNZ+UnntGyJ7u
         1LYA==
X-Gm-Message-State: APjAAAWuSiqObVvjJx+hBCfWLLYDaP+yhFyMI9vPxgiOnTsEQnDEAxQP
        852zpv7BrHU3pJNdvyhG+99qwcxWyu4=
X-Google-Smtp-Source: APXvYqwPrwaCqwJmTsBvyyjLyJcvTq09ZepuI44bbmNSKK6Ky+Diwbr40NVY49IX7vbv8sys9jbz9g==
X-Received: by 2002:a65:6688:: with SMTP id b8mr3331152pgw.81.1556795785150;
        Thu, 02 May 2019 04:16:25 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id t65sm5550010pfa.175.2019.05.02.04.16.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 May 2019 04:16:24 -0700 (PDT)
From:   Yash Shah <yash.shah@sifive.com>
To:     linux-edac@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@sifive.com, bp@alien8.de, james.morse@arm.com
Cc:     paul.walmsley@sifive.com, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, mchehab@kernel.org, sachin.ghadi@sifive.com,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        nicolas.ferre@microchip.com, paulmck@linux.ibm.com,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH] EDAC support for SiFive SoCs
Date:   Thu,  2 May 2019 16:46:00 +0530
Message-Id: <1556795761-21630-1-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Adds an EDAC platform driver for SiFive SoCs.

This patch was earlier part of the patch series:
'L2 cache controller and EDAC support for SiFive SoCs'
https://lkml.org/lkml/2019/4/15/320
In order to merge L2 cache controller driver without any dependency on EDAC,
this EDAC patch is re-posted separately with updated MAINTAINERS entry.

This patch depends on patch
'RISC-V: sifive_l2_cache: Add L2 cache controller driver for SiFive SoCs'
https://lkml.org/lkml/2019/5/2/309
The EDAC driver registers for notifier events from the L2 cache controller
driver (arch/riscv/mm/sifive_l2_cache.c) for L2 ECC events

The patch is based on Linux 5.1-rc2 and tested on HiFive Unleashed board
with additional board related patches needed for testing can be found at
dev/yashs/L2_cache_controller branch of:
https://github.com/yashshah7/riscv-linux.git

Yash Shah (1):
  edac: sifive: Add EDAC platform driver for SiFive SoCs

 MAINTAINERS                |   6 +++
 arch/riscv/Kconfig         |   1 +
 drivers/edac/Kconfig       |   6 +++
 drivers/edac/Makefile      |   1 +
 drivers/edac/sifive_edac.c | 121 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 135 insertions(+)
 create mode 100644 drivers/edac/sifive_edac.c

-- 
1.9.1

