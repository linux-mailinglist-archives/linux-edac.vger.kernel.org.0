Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D07091F09D5
	for <lists+linux-edac@lfdr.de>; Sun,  7 Jun 2020 06:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725998AbgFGEhd (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 7 Jun 2020 00:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgFGEhd (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 7 Jun 2020 00:37:33 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD67C08C5C2;
        Sat,  6 Jun 2020 21:37:33 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id r18so881982pgk.11;
        Sat, 06 Jun 2020 21:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UxKITpnOepHX3Q0tLOI7lVQPLbvDReCkw9mp7YHySQI=;
        b=hRnAJhIMir/67KOO13QQD4330fIka4alRb0XswMT1Y2F8QK+SK7hXaiJdl/nlOraTS
         D95zsOG/jbi/eAv9qFPZjZn1qylsmfZwtr7NlgxzNz5H9F4Fly48NYl6xAndoif45IJS
         FtiwjzpvORy15/UuvCY5aR+g9CuIVMZQVCRdkQKLwYEo9wrEHY8g5bBtRNpKBvR2YCEs
         TJdIOvtJPnAEgqTcpKUI+aQj6YvDWYMVv29UgsOfzq0SK1FBN0PeDEeMGN3LZfJWHIAR
         eX4kqYMSnEcfdlsIIcNdQF1v+8xuYmU2Q6gAsvpG/4WGvM85Ir+IaZCHYreeWcMDGBkJ
         r+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UxKITpnOepHX3Q0tLOI7lVQPLbvDReCkw9mp7YHySQI=;
        b=WtMX5aFMJv8+EfkekxEdmnxJNECO6i6S2fIcn4oyIoye6agbx075s7Wutb9m8LpgUI
         AG5lEichNvMIpqAdMpyIqvAKwuff7bE/OF2ZStqUK+t+d+Ovz6JBJiqhAj4CqJoG1USh
         /ppeucNUDLYeozRGj108tvDk6xq1BYjM6axKkte8O+ygMv1HCskLPgyxoZkv6to556WJ
         YmX0KzHEWUkHvanqBPvaxPcUzY6hZhI85fm625Emsro9dQaYsveeIlEAj5dtXM9ihWC/
         M0QAM1TiQirXooqEJwekPhFiqvNA/OdP/vlPTW/tIFeajSKDzil9WYJvdH4lTeOKDpa1
         DMHQ==
X-Gm-Message-State: AOAM531ZWNdqEl/YkixCeYn6fYtGdmdSXNlDA6jyDhKLPYqte6E+TOCd
        uW6mrvO+jx4UoR7DpAQvohkT/JAysA==
X-Google-Smtp-Source: ABdhPJzPWY2ycjDuQguhPpV2intjHxmMxRVdcVYebbug+6B7tUixno0V/SWYc5TXqpaFTqBY8jeWyQ==
X-Received: by 2002:a65:51c1:: with SMTP id i1mr15326798pgq.272.1591504652736;
        Sat, 06 Jun 2020 21:37:32 -0700 (PDT)
Received: from localhost (98.86.92.34.bc.googleusercontent.com. [34.92.86.98])
        by smtp.gmail.com with ESMTPSA id 141sm3507203pfz.171.2020.06.06.21.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2020 21:37:32 -0700 (PDT)
From:   Jacky Hu <hengqing.hu@gmail.com>
To:     linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, tony.luck@intel.com,
        x86@kernel.org, Jacky Hu <hengqing.hu@gmail.com>
Subject: [PATCH 0/2] MCA and EDAC updates for AMD Family 17h, Model 60h
Date:   Sun,  7 Jun 2020 12:37:07 +0800
Message-Id: <20200607043709.48178-1-hengqing.hu@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This patchset adds MCA and EDAC support for AMD Family 17h, Model 60h.

Also k10temp works with 4800h

k10temp-pci-00c3
Adapter: PCI adapter
Vcore:         1.55 V
Vsoc:          1.55 V
Tctl:         +49.6°C
Tdie:         +49.6°C
Icore:         0.00 A
Isoc:          0.00 A

Jacky Hu (2):
  x86/amd_nb: Add Family 17h, Model 60h PCI IDs
  EDAC/amd64: Add family ops for Family 17h Models 60h-6Fh

 arch/x86/kernel/amd_nb.c  |  5 +++++
 drivers/edac/amd64_edac.c | 14 ++++++++++++++
 drivers/edac/amd64_edac.h |  3 +++
 drivers/hwmon/k10temp.c   |  2 ++
 include/linux/pci_ids.h   |  1 +
 5 files changed, 25 insertions(+)

-- 
2.27.0

