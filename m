Return-Path: <linux-edac+bounces-5689-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMexDvVZfGkYMAIAu9opvQ
	(envelope-from <linux-edac+bounces-5689-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Fri, 30 Jan 2026 08:12:53 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7494B7CDB
	for <lists+linux-edac@lfdr.de>; Fri, 30 Jan 2026 08:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AE25930058D1
	for <lists+linux-edac@lfdr.de>; Fri, 30 Jan 2026 07:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5339D308F33;
	Fri, 30 Jan 2026 07:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VptVOXAf"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750302DF6E3
	for <linux-edac@vger.kernel.org>; Fri, 30 Jan 2026 07:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769757170; cv=none; b=evM5yoQDgUc1z69dET2F6FWN/F7mK/z/6DPmmKj+2kT6mS2ewlWFFkvokzq7gkzXkO6qh7Dp1ZvQ1ajnsteLldavcFSnvML7oC6R4n1cB84c58jBGWsZRWubC77bADAXaBgB3S5ErkdICTnUZN+XDxh2g43o+aUCVoSGlVLYxTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769757170; c=relaxed/simple;
	bh=pKUPM0wzpJm9Mc3wwZsmj8WZ4yFhWaMId95EY9YQLgs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pFGjGHyZEK5qP/eQpo1+48MYwz3zV5UC6MZsBpBWT1dMyPyNF9HxEIBGBgDKi+vt3Ee4KW3puduQ86iSWGCR6Gb7vOxqymWQJDGc/2ojMw7C4xNsPZBXU29xD5IuzyNWFaSD9L3QnS3cBGO33b0oXGx6zBK7Q7bnoXOG3uIi/0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VptVOXAf; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-c54f700b5b1so1099737a12.0
        for <linux-edac@vger.kernel.org>; Thu, 29 Jan 2026 23:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769757168; x=1770361968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=naIH/pjre7/XVHm34Cbcuw1zaZWvP8f51CxC45R0bx8=;
        b=VptVOXAfBg44+Ty6z+lZI7k6NFdGvFYDALfrTlUADS6n617NyafTpqh9lUGQeacSpF
         xSAJnhEm6ELJT/UlDhFpcCFHF02cYF8Djd9Dw+81Zqa/P/p4aQR8UlsfghPVEFyU4VdE
         nC2KtCU/M2BISin/gwCKe+Qk9odnCTnHwqwDH5sWU4+HhCp+Z2KDm+NTTAD7ZcqLswVy
         41X11Wc7ZI7FojOWY3ifcf+2h6jX3W+buHEeaX1se3W/yiznSqiDqXZSCq/To+MhASUV
         vvggSAisOESUAyqCJusTX9swygaLxKY60tjQFjc+iNSyOZUMLzA0G5fh2liQxN0e/oLh
         3szA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769757168; x=1770361968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=naIH/pjre7/XVHm34Cbcuw1zaZWvP8f51CxC45R0bx8=;
        b=wFq0hxCNeOnpBtCCqRzwYwxPwhIgXzfapgVbyCtG5FctaKF8xDxvPviDo1Vrc6XTdW
         qidzf//eF7wue3oWkR5qP8Ajf3QGVZs7byuI8xYtC2NbJ3JfyHGm5FOoweOmXeZEUI9F
         Lp3HkAGIJhU5YCFOqur3L4PzXlpAlrpToWDWp3kLDs2FiMicCRlVhORLgsb0xOaNEktZ
         WK7Cnga2KZGoniYV/MqLjWdhEAsH6QrzkHd1c2M2be45Pr3xLRSrK+rXglfpVRn9dtHH
         HILEA8hxrSBbyrgALJu74ktsrZ4OU5CIEyze8hURdTRfws7Nbdj/iXw71SgXa/bjWLtL
         dAPA==
X-Gm-Message-State: AOJu0Yw9zdwMtHI7xuGF1tluDy+v/NN4AJ85VKMAeiIC+K4GI++hTg5C
	B6qROQVyRMOqiQzMDgspXGZtF/0rRSFtcvKT+/QIKSxOv0eaDBre3b1iw6JTJfbt
X-Gm-Gg: AZuq6aJNi8QGTMpno5qjaRhU4Yb1oIeI6ViFhvdagpBZtH9eBHpohvGxvGl26eIufa8
	oy1haBfinCho1w336qtNxj8Sv+XSasRKrGq/5pt5gJjT8ICIXfRETEBHHHR53z9fPs3xMvYQYvn
	4dJs4olWtVmRDNOL0VhZTS3cofbdAgUf8LdFZ6H1MXB4ZHBMs9jnwcE0tATqyHuCUMywkjDFNz0
	MaC5r72ZZQiYjHrbFYUJPxgNC8ZN976YxJOuAzA6/zB+HOiduhC0eqtbMasvD1Avh9bX9QEzMir
	AcJc0tz0TpZhTmOmBjgbUoMdeHC+EIiz7rQUGYZal0GGVY/DyLH2r1M6eGuMJqzWgWwcbsDaWh8
	9edEgkKdAqq/TGhPSGJd4BodEz7KCTqcBk7ark491UUlsuzXTdn5pcr/9uLOmy0SdYt4u9vPTYS
	MGDDy7G29mVPHvwuXp2qui8C+SstcJ3ETqk5hDp1zbaLgS++CGtuFsYLeX4aLlnJa7HsyV5AOUp
	9ZjsqrMyYPuevCuncnTbmIV2SbiVtyd+m15V+n4pUE1w7LZcBzbgW1jYm7+N/DzWMI2MrCDWGPg
	0Ayu
X-Received: by 2002:a05:7301:1293:b0:2a4:65b5:9868 with SMTP id 5a478bee46e88-2b7c8909a48mr681384eec.38.1769750798205;
        Thu, 29 Jan 2026 21:26:38 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a16cfa25sm9747867eec.5.2026.01.29.21.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 21:26:37 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-edac@vger.kernel.org
Cc: Tim Small <tim@buttersideup.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	=?UTF-8?q?Martin=20Kepplinger-Novakovi=C4=87?= <martink@posteo.de>,
	Pavel Machek <pavel@ucw.cz>
Subject: [PATCH] edac: r82600: remove unused driver
Date: Thu, 29 Jan 2026 21:26:23 -0800
Message-ID: <20260130052633.13119-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[buttersideup.com,gmail.com,alien8.de,intel.com,linux-foundation.org,kernel.org,posteo.de,ucw.cz];
	TAGGED_FROM(0.00)[bounces-5689-lists,linux-edac=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,linux-edac@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-edac];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,radisys.com:url,nsa.gov:email]
X-Rspamd-Queue-Id: B7494B7CDB
X-Rspamd-Action: no action

This driver supports the Radisys 82600 embedded chipset, which was used
with Pentium III-era CPUs. It is highly unlikely that it is still used.
Besides its own documentation, the only information I was able to find
about the R82600, after looking through many pages of Google results,
was that it was used in a Nokia 2G GSM base station. Remove its driver
and add an entry for it to CREDITS.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
NOTE: this patch depends on my previous patch to remove i82443bxgx,
because it modifies the CREDITS entry that patch introduces.

 CREDITS                    |   1 +
 MAINTAINERS                |   6 -
 drivers/edac/Kconfig       |   7 -
 drivers/edac/Makefile      |   1 -
 drivers/edac/r82600_edac.c | 426 -------------------------------------
 5 files changed, 1 insertion(+), 440 deletions(-)
 delete mode 100644 drivers/edac/r82600_edac.c

diff --git a/CREDITS b/CREDITS
index 86276baea6ac..34f9748250d2 100644
--- a/CREDITS
+++ b/CREDITS
@@ -3774,6 +3774,7 @@ S: Australia
 N: Tim Small
 E: tim@buttersideup.com
 D: Intel 82443BX/GX (440BX/GX chipset) EDAC driver
+D: Radisys 82600 embedded chipset EDAC driver
 
 N: Stephen Smalley
 E: sds@tycho.nsa.gov
diff --git a/MAINTAINERS b/MAINTAINERS
index 0bc1a7de24d9..83f6b570453d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9150,12 +9150,6 @@ L:	linux-edac@vger.kernel.org
 S:	Maintained
 F:	drivers/edac/qcom_edac.c
 
-EDAC-R82600
-M:	Tim Small <tim@buttersideup.com>
-L:	linux-edac@vger.kernel.org
-S:	Maintained
-F:	drivers/edac/r82600_edac.c
-
 EDAC-SBRIDGE
 M:	Tony Luck <tony.luck@intel.com>
 R:	Qiuxu Zhuo <qiuxu.zhuo@intel.com>
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index b1dfb657f1b2..a44b85c440ca 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -215,13 +215,6 @@ config EDAC_I82860
 	  Support for error detection and correction on the Intel
 	  82860 chipset.
 
-config EDAC_R82600
-	tristate "Radisys 82600 embedded chipset"
-	depends on PCI && X86_32
-	help
-	  Support for error detection and correction on the Radisys
-	  82600 embedded chipset.
-
 config EDAC_I5000
 	tristate "Intel Greencreek/Blackford chipset"
 	depends on X86 && PCI
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index 4f6a46321b32..a37534300ab9 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -45,7 +45,6 @@ obj-$(CONFIG_EDAC_I3200)		+= i3200_edac.o
 obj-$(CONFIG_EDAC_IE31200)		+= ie31200_edac.o
 obj-$(CONFIG_EDAC_X38)			+= x38_edac.o
 obj-$(CONFIG_EDAC_I82860)		+= i82860_edac.o
-obj-$(CONFIG_EDAC_R82600)		+= r82600_edac.o
 obj-$(CONFIG_EDAC_AMD64)		+= amd64_edac.o
 
 obj-$(CONFIG_EDAC_PASEMI)		+= pasemi_edac.o
diff --git a/drivers/edac/r82600_edac.c b/drivers/edac/r82600_edac.c
deleted file mode 100644
index 61e979d5437a..000000000000
--- a/drivers/edac/r82600_edac.c
+++ /dev/null
@@ -1,426 +0,0 @@
-/*
- * Radisys 82600 Embedded chipset Memory Controller kernel module
- * (C) 2005 EADS Astrium
- * This file may be distributed under the terms of the
- * GNU General Public License.
- *
- * Written by Tim Small <tim@buttersideup.com>, based on work by Thayne
- * Harbaugh, Dan Hollis <goemon at anime dot net> and others.
- *
- * $Id: edac_r82600.c,v 1.1.2.6 2005/10/05 00:43:44 dsp_llnl Exp $
- *
- * Written with reference to 82600 High Integration Dual PCI System
- * Controller Data Book:
- * www.radisys.com/files/support_downloads/007-01277-0002.82600DataBook.pdf
- * references to this document given in []
- */
-
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/pci.h>
-#include <linux/pci_ids.h>
-#include <linux/edac.h>
-#include "edac_module.h"
-
-#define EDAC_MOD_STR	"r82600_edac"
-
-#define r82600_printk(level, fmt, arg...) \
-	edac_printk(level, "r82600", fmt, ##arg)
-
-#define r82600_mc_printk(mci, level, fmt, arg...) \
-	edac_mc_chipset_printk(mci, level, "r82600", fmt, ##arg)
-
-/* Radisys say "The 82600 integrates a main memory SDRAM controller that
- * supports up to four banks of memory. The four banks can support a mix of
- * sizes of 64 bit wide (72 bits with ECC) Synchronous DRAM (SDRAM) DIMMs,
- * each of which can be any size from 16MB to 512MB. Both registered (control
- * signals buffered) and unbuffered DIMM types are supported. Mixing of
- * registered and unbuffered DIMMs as well as mixing of ECC and non-ECC DIMMs
- * is not allowed. The 82600 SDRAM interface operates at the same frequency as
- * the CPU bus, 66MHz, 100MHz or 133MHz."
- */
-
-#define R82600_NR_CSROWS 4
-#define R82600_NR_CHANS  1
-#define R82600_NR_DIMMS  4
-
-#define R82600_BRIDGE_ID  0x8200
-
-/* Radisys 82600 register addresses - device 0 function 0 - PCI bridge */
-#define R82600_DRAMC	0x57	/* Various SDRAM related control bits
-				 * all bits are R/W
-				 *
-				 * 7    SDRAM ISA Hole Enable
-				 * 6    Flash Page Mode Enable
-				 * 5    ECC Enable: 1=ECC 0=noECC
-				 * 4    DRAM DIMM Type: 1=
-				 * 3    BIOS Alias Disable
-				 * 2    SDRAM BIOS Flash Write Enable
-				 * 1:0  SDRAM Refresh Rate: 00=Disabled
-				 *          01=7.8usec (256Mbit SDRAMs)
-				 *          10=15.6us 11=125usec
-				 */
-
-#define R82600_SDRAMC	0x76	/* "SDRAM Control Register"
-				 * More SDRAM related control bits
-				 * all bits are R/W
-				 *
-				 * 15:8 Reserved.
-				 *
-				 * 7:5  Special SDRAM Mode Select
-				 *
-				 * 4    Force ECC
-				 *
-				 *        1=Drive ECC bits to 0 during
-				 *          write cycles (i.e. ECC test mode)
-				 *
-				 *        0=Normal ECC functioning
-				 *
-				 * 3    Enhanced Paging Enable
-				 *
-				 * 2    CAS# Latency 0=3clks 1=2clks
-				 *
-				 * 1    RAS# to CAS# Delay 0=3 1=2
-				 *
-				 * 0    RAS# Precharge     0=3 1=2
-				 */
-
-#define R82600_EAP	0x80	/* ECC Error Address Pointer Register
-				 *
-				 * 31    Disable Hardware Scrubbing (RW)
-				 *        0=Scrub on corrected read
-				 *        1=Don't scrub on corrected read
-				 *
-				 * 30:12 Error Address Pointer (RO)
-				 *        Upper 19 bits of error address
-				 *
-				 * 11:4  Syndrome Bits (RO)
-				 *
-				 * 3     BSERR# on multibit error (RW)
-				 *        1=enable 0=disable
-				 *
-				 * 2     NMI on Single Bit Eror (RW)
-				 *        1=NMI triggered by SBE n.b. other
-				 *          prerequeists
-				 *        0=NMI not triggered
-				 *
-				 * 1     MBE (R/WC)
-				 *        read 1=MBE at EAP (see above)
-				 *        read 0=no MBE, or SBE occurred first
-				 *        write 1=Clear MBE status (must also
-				 *          clear SBE)
-				 *        write 0=NOP
-				 *
-				 * 1     SBE (R/WC)
-				 *        read 1=SBE at EAP (see above)
-				 *        read 0=no SBE, or MBE occurred first
-				 *        write 1=Clear SBE status (must also
-				 *          clear MBE)
-				 *        write 0=NOP
-				 */
-
-#define R82600_DRBA	0x60	/* + 0x60..0x63 SDRAM Row Boundary Address
-				 *  Registers
-				 *
-				 * 7:0  Address lines 30:24 - upper limit of
-				 * each row [p57]
-				 */
-
-struct r82600_error_info {
-	u32 eapr;
-};
-
-static bool disable_hardware_scrub;
-
-static struct edac_pci_ctl_info *r82600_pci;
-
-static void r82600_get_error_info(struct mem_ctl_info *mci,
-				struct r82600_error_info *info)
-{
-	struct pci_dev *pdev;
-
-	pdev = to_pci_dev(mci->pdev);
-	pci_read_config_dword(pdev, R82600_EAP, &info->eapr);
-
-	if (info->eapr & BIT(0))
-		/* Clear error to allow next error to be reported [p.62] */
-		pci_write_bits32(pdev, R82600_EAP,
-				 ((u32) BIT(0) & (u32) BIT(1)),
-				 ((u32) BIT(0) & (u32) BIT(1)));
-
-	if (info->eapr & BIT(1))
-		/* Clear error to allow next error to be reported [p.62] */
-		pci_write_bits32(pdev, R82600_EAP,
-				 ((u32) BIT(0) & (u32) BIT(1)),
-				 ((u32) BIT(0) & (u32) BIT(1)));
-}
-
-static int r82600_process_error_info(struct mem_ctl_info *mci,
-				struct r82600_error_info *info,
-				int handle_errors)
-{
-	int error_found;
-	u32 eapaddr, page;
-	u32 syndrome;
-
-	error_found = 0;
-
-	/* bits 30:12 store the upper 19 bits of the 32 bit error address */
-	eapaddr = ((info->eapr >> 12) & 0x7FFF) << 13;
-	/* Syndrome in bits 11:4 [p.62]       */
-	syndrome = (info->eapr >> 4) & 0xFF;
-
-	/* the R82600 reports at less than page *
-	 * granularity (upper 19 bits only)     */
-	page = eapaddr >> PAGE_SHIFT;
-
-	if (info->eapr & BIT(0)) {	/* CE? */
-		error_found = 1;
-
-		if (handle_errors)
-			edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci, 1,
-					     page, 0, syndrome,
-					     edac_mc_find_csrow_by_page(mci, page),
-					     0, -1,
-					     mci->ctl_name, "");
-	}
-
-	if (info->eapr & BIT(1)) {	/* UE? */
-		error_found = 1;
-
-		if (handle_errors)
-			/* 82600 doesn't give enough info */
-			edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci, 1,
-					     page, 0, 0,
-					     edac_mc_find_csrow_by_page(mci, page),
-					     0, -1,
-					     mci->ctl_name, "");
-	}
-
-	return error_found;
-}
-
-static void r82600_check(struct mem_ctl_info *mci)
-{
-	struct r82600_error_info info;
-
-	r82600_get_error_info(mci, &info);
-	r82600_process_error_info(mci, &info, 1);
-}
-
-static inline int ecc_enabled(u8 dramcr)
-{
-	return dramcr & BIT(5);
-}
-
-static void r82600_init_csrows(struct mem_ctl_info *mci, struct pci_dev *pdev,
-			u8 dramcr)
-{
-	struct csrow_info *csrow;
-	struct dimm_info *dimm;
-	int index;
-	u8 drbar;		/* SDRAM Row Boundary Address Register */
-	u32 row_high_limit, row_high_limit_last;
-	u32 reg_sdram, ecc_on, row_base;
-
-	ecc_on = ecc_enabled(dramcr);
-	reg_sdram = dramcr & BIT(4);
-	row_high_limit_last = 0;
-
-	for (index = 0; index < mci->nr_csrows; index++) {
-		csrow = mci->csrows[index];
-		dimm = csrow->channels[0]->dimm;
-
-		/* find the DRAM Chip Select Base address and mask */
-		pci_read_config_byte(pdev, R82600_DRBA + index, &drbar);
-
-		edac_dbg(1, "Row=%d DRBA = %#0x\n", index, drbar);
-
-		row_high_limit = ((u32) drbar << 24);
-/*		row_high_limit = ((u32)drbar << 24) | 0xffffffUL; */
-
-		edac_dbg(1, "Row=%d, Boundary Address=%#0x, Last = %#0x\n",
-			 index, row_high_limit, row_high_limit_last);
-
-		/* Empty row [p.57] */
-		if (row_high_limit == row_high_limit_last)
-			continue;
-
-		row_base = row_high_limit_last;
-
-		csrow->first_page = row_base >> PAGE_SHIFT;
-		csrow->last_page = (row_high_limit >> PAGE_SHIFT) - 1;
-
-		dimm->nr_pages = csrow->last_page - csrow->first_page + 1;
-		/* Error address is top 19 bits - so granularity is      *
-		 * 14 bits                                               */
-		dimm->grain = 1 << 14;
-		dimm->mtype = reg_sdram ? MEM_RDDR : MEM_DDR;
-		/* FIXME - check that this is unknowable with this chipset */
-		dimm->dtype = DEV_UNKNOWN;
-
-		/* Mode is global on 82600 */
-		dimm->edac_mode = ecc_on ? EDAC_SECDED : EDAC_NONE;
-		row_high_limit_last = row_high_limit;
-	}
-}
-
-static int r82600_probe1(struct pci_dev *pdev, int dev_idx)
-{
-	struct mem_ctl_info *mci;
-	struct edac_mc_layer layers[2];
-	u8 dramcr;
-	u32 eapr;
-	u32 scrub_disabled;
-	u32 sdram_refresh_rate;
-	struct r82600_error_info discard;
-
-	edac_dbg(0, "\n");
-	pci_read_config_byte(pdev, R82600_DRAMC, &dramcr);
-	pci_read_config_dword(pdev, R82600_EAP, &eapr);
-	scrub_disabled = eapr & BIT(31);
-	sdram_refresh_rate = dramcr & (BIT(0) | BIT(1));
-	edac_dbg(2, "sdram refresh rate = %#0x\n", sdram_refresh_rate);
-	edac_dbg(2, "DRAMC register = %#0x\n", dramcr);
-	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
-	layers[0].size = R82600_NR_CSROWS;
-	layers[0].is_virt_csrow = true;
-	layers[1].type = EDAC_MC_LAYER_CHANNEL;
-	layers[1].size = R82600_NR_CHANS;
-	layers[1].is_virt_csrow = false;
-	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers, 0);
-	if (mci == NULL)
-		return -ENOMEM;
-
-	edac_dbg(0, "mci = %p\n", mci);
-	mci->pdev = &pdev->dev;
-	mci->mtype_cap = MEM_FLAG_RDDR | MEM_FLAG_DDR;
-	mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_EC | EDAC_FLAG_SECDED;
-	/* FIXME try to work out if the chip leads have been used for COM2
-	 * instead on this board? [MA6?] MAYBE:
-	 */
-
-	/* On the R82600, the pins for memory bits 72:65 - i.e. the   *
-	 * EC bits are shared with the pins for COM2 (!), so if COM2  *
-	 * is enabled, we assume COM2 is wired up, and thus no EDAC   *
-	 * is possible.                                               */
-	mci->edac_cap = EDAC_FLAG_NONE | EDAC_FLAG_EC | EDAC_FLAG_SECDED;
-
-	if (ecc_enabled(dramcr)) {
-		if (scrub_disabled)
-			edac_dbg(3, "mci = %p - Scrubbing disabled! EAP: %#0x\n",
-				 mci, eapr);
-	} else
-		mci->edac_cap = EDAC_FLAG_NONE;
-
-	mci->mod_name = EDAC_MOD_STR;
-	mci->ctl_name = "R82600";
-	mci->dev_name = pci_name(pdev);
-	mci->edac_check = r82600_check;
-	mci->ctl_page_to_phys = NULL;
-	r82600_init_csrows(mci, pdev, dramcr);
-	r82600_get_error_info(mci, &discard);	/* clear counters */
-
-	/* Here we assume that we will never see multiple instances of this
-	 * type of memory controller.  The ID is therefore hardcoded to 0.
-	 */
-	if (edac_mc_add_mc(mci)) {
-		edac_dbg(3, "failed edac_mc_add_mc()\n");
-		goto fail;
-	}
-
-	/* get this far and it's successful */
-
-	if (disable_hardware_scrub) {
-		edac_dbg(3, "Disabling Hardware Scrub (scrub on error)\n");
-		pci_write_bits32(pdev, R82600_EAP, BIT(31), BIT(31));
-	}
-
-	/* allocating generic PCI control info */
-	r82600_pci = edac_pci_create_generic_ctl(&pdev->dev, EDAC_MOD_STR);
-	if (!r82600_pci) {
-		printk(KERN_WARNING
-			"%s(): Unable to create PCI control\n",
-			__func__);
-		printk(KERN_WARNING
-			"%s(): PCI error report via EDAC not setup\n",
-			__func__);
-	}
-
-	edac_dbg(3, "success\n");
-	return 0;
-
-fail:
-	edac_mc_free(mci);
-	return -ENODEV;
-}
-
-/* returns count (>= 0), or negative on error */
-static int r82600_init_one(struct pci_dev *pdev,
-			   const struct pci_device_id *ent)
-{
-	edac_dbg(0, "\n");
-
-	/* don't need to call pci_enable_device() */
-	return r82600_probe1(pdev, ent->driver_data);
-}
-
-static void r82600_remove_one(struct pci_dev *pdev)
-{
-	struct mem_ctl_info *mci;
-
-	edac_dbg(0, "\n");
-
-	if (r82600_pci)
-		edac_pci_release_generic_ctl(r82600_pci);
-
-	if ((mci = edac_mc_del_mc(&pdev->dev)) == NULL)
-		return;
-
-	edac_mc_free(mci);
-}
-
-static const struct pci_device_id r82600_pci_tbl[] = {
-	{
-	 PCI_DEVICE(PCI_VENDOR_ID_RADISYS, R82600_BRIDGE_ID)
-	 },
-	{
-	 0,
-	 }			/* 0 terminated list. */
-};
-
-MODULE_DEVICE_TABLE(pci, r82600_pci_tbl);
-
-static struct pci_driver r82600_driver = {
-	.name = EDAC_MOD_STR,
-	.probe = r82600_init_one,
-	.remove = r82600_remove_one,
-	.id_table = r82600_pci_tbl,
-};
-
-static int __init r82600_init(void)
-{
-       /* Ensure that the OPSTATE is set correctly for POLL or NMI */
-       opstate_init();
-
-	return pci_register_driver(&r82600_driver);
-}
-
-static void __exit r82600_exit(void)
-{
-	pci_unregister_driver(&r82600_driver);
-}
-
-module_init(r82600_init);
-module_exit(r82600_exit);
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Tim Small <tim@buttersideup.com> - WPAD Ltd. on behalf of EADS Astrium");
-MODULE_DESCRIPTION("MC support for Radisys 82600 memory controllers");
-
-module_param(disable_hardware_scrub, bool, 0644);
-MODULE_PARM_DESC(disable_hardware_scrub,
-		 "If set, disable the chipset's automatic scrub for CEs");
-
-module_param(edac_op_state, int, 0444);
-MODULE_PARM_DESC(edac_op_state, "EDAC Error Reporting state: 0=Poll,1=NMI");
-- 
2.43.0


