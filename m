Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8991CCDFE
	for <lists+linux-edac@lfdr.de>; Sun, 10 May 2020 22:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbgEJUwc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 10 May 2020 16:52:32 -0400
Received: from mail.ispras.ru ([83.149.199.45]:52896 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729216AbgEJUwc (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sun, 10 May 2020 16:52:32 -0400
Received: from localhost.localdomain (unknown [46.188.10.168])
        by mail.ispras.ru (Postfix) with ESMTPSA id C465ACD46A;
        Sun, 10 May 2020 23:52:29 +0300 (MSK)
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
Subject: [PATCH 2/3] hwmon: (k10temp) Add AMD family 17h model 60h PCI match
Date:   Sun, 10 May 2020 20:48:41 +0000
Message-Id: <20200510204842.2603-3-amonakov@ispras.ru>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200510204842.2603-1-amonakov@ispras.ru>
References: <20200510204842.2603-1-amonakov@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add support for retrieving Tdie and Tctl on AMD Renoir (4000-series
Ryzen CPUs).

It appears SMU offsets for reading current/voltage and CCD temperature
have changed for this generation (reads from currently used offsets
yield zeros), so those features cannot be enabled so trivially.

Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
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
---
 drivers/hwmon/k10temp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 9915578533bb..8f12995ec133 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -632,6 +632,7 @@ static const struct pci_device_id k10temp_id_table[] = {
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F3) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M60H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F3) },
 	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{}
-- 
2.26.2

