Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72591CCE01
	for <lists+linux-edac@lfdr.de>; Sun, 10 May 2020 22:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbgEJUwc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 10 May 2020 16:52:32 -0400
Received: from mail.ispras.ru ([83.149.199.45]:52852 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729380AbgEJUwc (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sun, 10 May 2020 16:52:32 -0400
Received: from localhost.localdomain (unknown [46.188.10.168])
        by mail.ispras.ru (Postfix) with ESMTPSA id C7DFECD464;
        Sun, 10 May 2020 23:52:28 +0300 (MSK)
From:   Alexander Monakov <amonakov@ispras.ru>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Monakov <amonakov@ispras.ru>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Brian Woods <brian.woods@amd.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-edac@vger.kernel.org
Subject: [PATCH 0/3] k10temp and EDAC support for AMD Renoir
Date:   Sun, 10 May 2020 20:48:39 +0000
Message-Id: <20200510204842.2603-1-amonakov@ispras.ru>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hello!

This simple patch series adds support for new AMD Ryzen CPU generation
(model 17h family 60h) by adding the new PCI IDs as appropriate in the
amd_nb, k10temp and amd64_edac drivers.

The change in k10temp is the one most important for users (temperature
sensors of the new CPUs), the amd_nb patch is a prerequisite for that,
and finally edac_amd64 patch is necessary, because otherwise loading
that module produces a warning due to incomplete support.

Thank you.

Alexander Monakov (3):
  x86/amd_nb: add AMD family 17h model 60h PCI IDs
  hwmon: (k10temp) Add AMD family 17h model 60h PCI match
  EDAC/amd64: Add AMD family 17h model 60h PCI IDs

 arch/x86/kernel/amd_nb.c  |  5 +++++
 drivers/edac/amd64_edac.c | 14 ++++++++++++++
 drivers/edac/amd64_edac.h |  3 +++
 drivers/hwmon/k10temp.c   |  1 +
 include/linux/pci_ids.h   |  1 +
 5 files changed, 24 insertions(+)

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Brian Woods <brian.woods@amd.com>
Cc: Clemens Ladisch <clemens@ladisch.de>
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org
Cc: linux-edac@vger.kernel.org
-- 
2.26.2

