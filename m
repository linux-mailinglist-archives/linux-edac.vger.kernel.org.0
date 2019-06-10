Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15A4B3BCA5
	for <lists+linux-edac@lfdr.de>; Mon, 10 Jun 2019 21:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388901AbfFJTPQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 10 Jun 2019 15:15:16 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:39237 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389248AbfFJTOi (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 10 Jun 2019 15:14:38 -0400
Received: by mail-qk1-f201.google.com with SMTP id s67so8938644qkc.6
        for <linux-edac@vger.kernel.org>; Mon, 10 Jun 2019 12:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EO7j56MdfFzt2mRyj8hcm1iy8vmSJAjtXZ/C0wTp1G8=;
        b=h7LC7ANdx3e2J44+ya0wOf/+L99eKH6ZAkhtZrEe1sUe9coeBLBFp3f5wxwwOlq8Tr
         nOY3PBwhwmmYAeW+zdl5LlEKj/6vTj1ygxVdgMpVittriy27WWV3t1qCk+iolDBw5Kub
         STjNeWhktsSS7q5RSwIGk22YvHod/drcBYEx2jLpawLjzFmJSCfqoO1Wi6Fe8uh8mxu+
         MGf73/Y71GX+IH+nueRLGPW0N6vHEBR9zKekYA+ACJOtls3vs5pxLFXgcFyQR0t/FzkP
         wfAhI686yfg3nxgigE/tiafWJ6z18PHqRKRF122uEePQtFgIEFc3Iy3cH73wPGeFa2eG
         Vxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EO7j56MdfFzt2mRyj8hcm1iy8vmSJAjtXZ/C0wTp1G8=;
        b=e+7KjgmC6GwQi7Tcl+kJeoolfE7v6uS+KbLjb4mnHfBn068ySILMQ+89tvrGGgU6pd
         IV+YozwHHkFhEwoL/5fDri2dZ68ZimDpEaCPGZYXZamg9GzIYMlKl+wv40cPD9mQ/PV1
         kP4zeIvM2SW9LberrbmJ7rMf9VL16ylurJemmtbKYcPxlHgBWsj8Ey78tUqGBmY3s3S4
         Css3Zf0IYemmdtHtjLVpnA77379z52YW+Ua1vNoeZOXMVb7zfm/l/Umkln49ZmYhza6J
         HeTJ86c+vrFYc2fBpdxxRaGNbHiHGfeCBnOwC3Xx6c3R/gz7CkVedTl0YTo9GUkU8Xmw
         aIeA==
X-Gm-Message-State: APjAAAX9L0dhDPqwGoDsR4Hiw6Z6yubM0yQ3S/998EyGWPlc7s5Dlt5C
        /AVdBEY3ibFWa/WWU/NMEmPp99YrmA==
X-Google-Smtp-Source: APXvYqxNPnIFxxINIYDtDDu/aEs3s+8rHjgSUxnJ/V0Z/39cRDAChET+x4aUy8tGTPerYWUaS2zaXE3dZg==
X-Received: by 2002:ac8:19ac:: with SMTP id u41mr42837147qtj.46.1560194077300;
 Mon, 10 Jun 2019 12:14:37 -0700 (PDT)
Date:   Mon, 10 Jun 2019 21:14:22 +0200
In-Reply-To: <20190610191422.177931-1-elver@google.com>
Message-Id: <20190610191422.177931-2-elver@google.com>
Mime-Version: 1.0
References: <20190610191422.177931-1-elver@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v2 2/2] EDAC, ie31200: Reformat PCI device table
From:   Marco Elver <elver@google.com>
To:     bp@alien8.de, tony.luck@intel.com, jbaron@akamai.com
Cc:     linux-kernel@vger.kernel.org, Marco Elver <elver@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Reformat device table after Coffee Lake additions to be more readable.

No functional change.

Signed-off-by: Marco Elver <elver@google.com>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
---
 drivers/edac/ie31200_edac.c | 80 ++++++++++---------------------------
 1 file changed, 20 insertions(+), 60 deletions(-)

diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
index cdb26014d929..af4ca4ee7df2 100644
--- a/drivers/edac/ie31200_edac.c
+++ b/drivers/edac/ie31200_edac.c
@@ -564,66 +564,26 @@ static void ie31200_remove_one(struct pci_dev *pdev)
 }
 
 static const struct pci_device_id ie31200_pci_tbl[] = {
-	{
-		PCI_VEND_DEV(INTEL, IE31200_HB_1), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		IE31200},
-	{
-		PCI_VEND_DEV(INTEL, IE31200_HB_2), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		IE31200},
-	{
-		PCI_VEND_DEV(INTEL, IE31200_HB_3), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		IE31200},
-	{
-		PCI_VEND_DEV(INTEL, IE31200_HB_4), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		IE31200},
-	{
-		PCI_VEND_DEV(INTEL, IE31200_HB_5), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		IE31200},
-	{
-		PCI_VEND_DEV(INTEL, IE31200_HB_6), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		IE31200},
-	{
-		PCI_VEND_DEV(INTEL, IE31200_HB_7), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		IE31200},
-	{
-		PCI_VEND_DEV(INTEL, IE31200_HB_8), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		IE31200},
-	{
-		PCI_VEND_DEV(INTEL, IE31200_HB_9), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		IE31200},
-	{
-		PCI_VEND_DEV(INTEL, IE31200_HB_CFL_1), PCI_ANY_ID, PCI_ANY_ID,
-		0, 0, IE31200},
-	{
-		PCI_VEND_DEV(INTEL, IE31200_HB_CFL_2), PCI_ANY_ID, PCI_ANY_ID,
-		0, 0, IE31200},
-	{
-		PCI_VEND_DEV(INTEL, IE31200_HB_CFL_3), PCI_ANY_ID, PCI_ANY_ID,
-		0, 0, IE31200},
-	{
-		PCI_VEND_DEV(INTEL, IE31200_HB_CFL_4), PCI_ANY_ID, PCI_ANY_ID,
-		0, 0, IE31200},
-	{
-		PCI_VEND_DEV(INTEL, IE31200_HB_CFL_5), PCI_ANY_ID, PCI_ANY_ID,
-		0, 0, IE31200},
-	{
-		PCI_VEND_DEV(INTEL, IE31200_HB_CFL_6), PCI_ANY_ID, PCI_ANY_ID,
-		0, 0, IE31200},
-	{
-		PCI_VEND_DEV(INTEL, IE31200_HB_CFL_7), PCI_ANY_ID, PCI_ANY_ID,
-		0, 0, IE31200},
-	{
-		PCI_VEND_DEV(INTEL, IE31200_HB_CFL_8), PCI_ANY_ID, PCI_ANY_ID,
-		0, 0, IE31200},
-	{
-		PCI_VEND_DEV(INTEL, IE31200_HB_CFL_9), PCI_ANY_ID, PCI_ANY_ID,
-		0, 0, IE31200},
-	{
-		PCI_VEND_DEV(INTEL, IE31200_HB_CFL_10), PCI_ANY_ID, PCI_ANY_ID,
-		0, 0, IE31200},
-	{
-		0,
-	}            /* 0 terminated list. */
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_1),      PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_2),      PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_3),      PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_4),      PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_5),      PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_6),      PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_7),      PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_8),      PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_9),      PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_1),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_2),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_3),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_4),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_5),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_6),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_7),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_8),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_9),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_10), PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
+	{ 0, } /* 0 terminated list. */
 };
 MODULE_DEVICE_TABLE(pci, ie31200_pci_tbl);
 
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

