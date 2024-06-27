Return-Path: <linux-edac+bounces-1414-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB93291AE2E
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jun 2024 19:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E6EBB29BC8
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jun 2024 17:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9475319AA58;
	Thu, 27 Jun 2024 17:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5WU1y3F"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABBB1A08C6;
	Thu, 27 Jun 2024 17:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719509606; cv=none; b=oZXQc99y8G/Et/eS1Sb76wSg29H6UB11KpHf0y6c8l1SITNVOzYcrqHpWI/UNSYuYIRKoULrLnVkU02XOq/90j9EOCf3L7q03UwkUkj6BW1WPu60HUzMPzN4EHBADjcDDDW7YSUXYL0tjRvVwGVohtfM76ctoAH4hQAaAZtjmYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719509606; c=relaxed/simple;
	bh=2VBnWtOUYOYZx3D0CXbbsv1cQZySxF7anmw1+oL7qNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MGw5Q57m806d21POTyt1q1TSKY4T/I467St2+U5+3e6DTwuW24cBFLEzXRXRdA7TzS83pERRN7NL1P5noYmgugKSg+oXiqod5O1d/3yLFlcBx3Bl/UhSe/j937OAC3xuVx1U8o6LNQKFJ1W6jSkJNDsJB2jXimpNqy/kdP1KauY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5WU1y3F; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52cd80e55efso11505470e87.0;
        Thu, 27 Jun 2024 10:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719509602; x=1720114402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+o0t5l+gbhBR5sr353Zx4OwnR+/NtUKsRVbiL7FnCuk=;
        b=R5WU1y3FYaHxbSUlomxZ1dEWM6q2zrNY0el3mbGfcF1lP8l0yJalpBOWnQwG8zNPTC
         x+6i1nR86cXmm3K3ib5K1YfGUfvhY7suMVzUH2sFjChpQXYzyZVqkiFPwXG2gCghukfA
         tErZbEvwG3UNgECVI5u1msm4/QfxNBbcMIsHnMOEsMTCywmofFqLEjAM8eShU4g5yIPC
         aIeC9Z3ta1hXTrlhW4ZaArGE/r/DffDxKR6is4ZS7NHgw75py4CnjVu8wLEifuPc2Qwa
         ZfBiwS8Xb9xMAv748WJx8UZFER957LNuB07xVoosHWHlAcvTyove6rAfcEJFOBMmHoGd
         PRgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719509602; x=1720114402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+o0t5l+gbhBR5sr353Zx4OwnR+/NtUKsRVbiL7FnCuk=;
        b=HrwwYxc1jclNtiEGBb4haWpGbLD2Bgj5wYrfF0WJzRXt/VznR4U94QRUKYDwypgEf/
         0uMVb+JZcW2zkcCodCKgzkExGTnSIJqarkDjlw0KGFYcXxHAyHawwMQR9h1ZmJOfWRhu
         nJBJOJ/IK0h2h3NyQYvNiAigudM5+4ZdA+SfRl+7fUguEbML9fgEjWyyDxevUIXVGpWT
         fhzbZx8n/OlKTbOdDax7qFRFnow0gkNWtGfaObK92GLAA5zoV+svwCvRdhP65ZJoaKpN
         fYNoHMZocoSilVMe4dEUfWOI1XDr8HqMBiSKPjuEA2PkKE0Aef2R1eIx0r4KkqN9myDe
         fFQg==
X-Forwarded-Encrypted: i=1; AJvYcCVUhrvoyAKAv03MdGAX6+tN13LCUggGshmaILE5X5IcpGgZBTN9xt4RLbdiWXtyaz1R+1xuioS8841kU7THoFNyJ6puF7y/jj8qJL2iTF5i7f3Aszt8Mlf+Hs3bwhcxu/qglEDwRvkANA==
X-Gm-Message-State: AOJu0YxBng/P85XrkMXUoh6vpqy/lT04MUS8gzzzf+zgtADyystTDETG
	ucntGAY87bp6Y5QALFGyHNR1FCiHOlrzWmpvHghUVJvcCP5sCAc/
X-Google-Smtp-Source: AGHT+IFghayRhLz4uxIDL4vu9rwoG8YPDZ1hjqc0Z7OjlBf0v3MkYxcg9EZV6XH6LzZ4yQcswu6v3g==
X-Received: by 2002:ac2:5e79:0:b0:52c:8909:bd35 with SMTP id 2adb3069b0e04-52ce182bc95mr10723507e87.10.1719509601911;
        Thu, 27 Jun 2024 10:33:21 -0700 (PDT)
Received: from localhost ([213.79.110.82])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab27b81sm30e87.163.2024.06.27.10.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 10:33:21 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Michal Simek <michal.simek@amd.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v6 11/18] EDAC/mc: Init DIMM labels in MC registration method
Date: Thu, 27 Jun 2024 20:32:18 +0300
Message-ID: <20240627173251.25718-12-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240627173251.25718-1-fancer.lancer@gmail.com>
References: <20240627173251.25718-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the DIMM labels initialization to the memory controller registration
method as a preparation before adding the generic procedure to allocate an
unique MC index. It's required because the DIMM labels contain the MC
index as the "mc%u" part of the string, which in case of the
auto-generated index isn't available at the moment of the MCI/csrow/dimms
descriptor allocation.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/edac/edac_mc.c | 48 +++++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index d6eed727b0cd..c0b36349999f 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -257,7 +257,6 @@ static int edac_mc_alloc_dimms(struct mem_ctl_info *mci)
 	unsigned int pos[EDAC_MAX_LAYERS];
 	unsigned int row, chn, idx;
 	int layer;
-	void *p;
 
 	/*
 	 * Allocate and fill the dimm structs
@@ -272,7 +271,6 @@ static int edac_mc_alloc_dimms(struct mem_ctl_info *mci)
 	for (idx = 0; idx < mci->tot_dimms; idx++) {
 		struct dimm_info *dimm;
 		struct rank_info *chan;
-		int n, len;
 
 		chan = mci->csrows[row]->channels[chn];
 
@@ -283,22 +281,9 @@ static int edac_mc_alloc_dimms(struct mem_ctl_info *mci)
 		dimm->mci = mci;
 		dimm->idx = idx;
 
-		/*
-		 * Copy DIMM location and initialize it.
-		 */
-		len = sizeof(dimm->label);
-		p = dimm->label;
-		n = scnprintf(p, len, "mc#%u", mci->mc_idx);
-		p += n;
-		len -= n;
-		for (layer = 0; layer < mci->n_layers; layer++) {
-			n = scnprintf(p, len, "%s#%u",
-				      edac_layer_name[mci->layers[layer].type],
-				      pos[layer]);
-			p += n;
-			len -= n;
+		/* Copy DIMM location */
+		for (layer = 0; layer < mci->n_layers; layer++)
 			dimm->location[layer] = pos[layer];
-		}
 
 		/* Link it to the csrows old API data */
 		chan->dimm = dimm;
@@ -511,6 +496,33 @@ void edac_mc_reset_delay_period(unsigned long value)
 
 
 
+/**
+ * edac_mc_init_labels() - Initialize DIMM labels
+ *
+ * @mci: pointer to the mci structure which DIMM labels need to be initialized
+ *
+ * .. note::
+ *	locking model: must be called with the mem_ctls_mutex lock held
+ */
+static void edac_mc_init_labels(struct mem_ctl_info *mci)
+{
+	int n, len, layer;
+	unsigned int idx;
+	char *p;
+
+	for (idx = 0; idx < mci->tot_dimms; idx++) {
+		len = sizeof(mci->dimms[idx]->label);
+		p = mci->dimms[idx]->label;
+
+		n = scnprintf(p, len, "mc#%u", mci->mc_idx);
+		for (layer = 0; layer < mci->n_layers; layer++) {
+			n += scnprintf(p + n, len - n, "%s#%u",
+				      edac_layer_name[mci->layers[layer].type],
+				      mci->dimms[idx]->location[layer]);
+		}
+	}
+}
+
 /* Return 0 on success, 1 on failure.
  * Before calling this function, caller must
  * assign a unique value to mci->mc_idx.
@@ -638,6 +650,8 @@ int edac_mc_add_mc_with_groups(struct mem_ctl_info *mci,
 		goto fail0;
 	}
 
+	edac_mc_init_labels(mci);
+
 	if (add_mc_to_global_list(mci))
 		goto fail0;
 
-- 
2.43.0


