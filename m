Return-Path: <linux-edac+bounces-3363-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F013DA65FC7
	for <lists+linux-edac@lfdr.de>; Mon, 17 Mar 2025 21:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 523CE178E2C
	for <lists+linux-edac@lfdr.de>; Mon, 17 Mar 2025 20:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964801F5847;
	Mon, 17 Mar 2025 20:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="LV2Uoj8L"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F373D6A
	for <linux-edac@vger.kernel.org>; Mon, 17 Mar 2025 20:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742244920; cv=none; b=HsuPOQLk1wk5Zc8jcKqJoNutfUDJKLxx4DXS1bin4RPtoHizPGftvNE0LdlyiFS/zo4JRKtWMF8lFbZDxPAHL2uBw59VTdi/s978ome/kWtByMpnhIp/4NMLr3+BojFgqgkHm9vTPaXIQsvS1K5hYxwevuyIJyp1rbA2c9FgapQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742244920; c=relaxed/simple;
	bh=ZTfeW4lIxaywxkO8YqYFYqa7CSW6sPE5j9OCLcLq5tY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hLCFBsA57HiOVoeDL36rvZh41g4zKPMATQGiL2/6i5I2CVmoaNXx9S58FYTEFZ1tE+QFnIwM25bRmwWbL5kpZwyxxK09VpfW7rjGyZPt5/P9edHIqk/fDq1PTcw580VhPUxPMTuP2WRMUhxGhs1FDgSFzcAZ+YPj5oi1CQBIkA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sargun.me; spf=pass smtp.mailfrom=sargun.me; dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b=LV2Uoj8L; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sargun.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sargun.me
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e63ecbb8b91so428473276.1
        for <linux-edac@vger.kernel.org>; Mon, 17 Mar 2025 13:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google; t=1742244917; x=1742849717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uH6zXcWRgDlv69AYoY+cQU8cnjmRD3eomKeXACMA7uk=;
        b=LV2Uoj8LNrdtG4wa1vpmoGZP1wu7kC/M515JH03LrBQ22Uvg+kiUuBjqlaTQc0HF4w
         K5AWqpzLHN+VjatLf57nAc/3LKcLbYpxRPaRV5Wb4MGpIdeva4qXd5/DmKFJro9Lnipf
         0zYC2T60KT+HAbvRp0Ju902JzgA9FVXC9NSoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742244917; x=1742849717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uH6zXcWRgDlv69AYoY+cQU8cnjmRD3eomKeXACMA7uk=;
        b=ikqNJMoIsiN6bB2ZITyTramAHSYOcfusOUDVlixXBgWXISfvZmWIMX4EgoMWZgofV3
         fnstCrIDwyiWrp15he4vhmGzcs9AU9RbPsQ8Oni+lIVliYBkYEY9/PNzVo2v3V3p8vKd
         NugnhxqukCvq3ItTI+Vb2TSsgXSPYWf0D/d0j8U2R1A229vJ4yJtzh4saKbFOO1hbUF8
         CFJJi/brkBnfecDeRWkUa5g6tpntvZ1WlLbn7CV0uXUIBHW7FxoVzlLO8pbhZAin7vSI
         HvidqwGBHnxhpka7Khhjg0Ge8oLSTKJvR6Pcj9XhiNqX8xcsdy2Qg4vrZNpuE8r6guXB
         HBpQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/Sx69nV1W325/xoTRvJXJLHGLPFBTXBWLIYqZ6JJ/ps4zbhOpxXL53m+RuuGoXOYBtedYkBBHvLPM@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkfw/nqNjLel1rxUqibiJPpxKBJ1ngcmJxImurXdGKzvfdGHiX
	w38kQn+cMseocWN6QX61Z7pWDlxP4KNeUAQd9ZgCaNeygRcYvtsWxlFYe5pt+wA=
X-Gm-Gg: ASbGnct2qgPjWqTPC9GpoOTrgvsVL3ziYKj8xVa8tJjXvOtrLQ6w1JaF5oxSPh1cmq0
	LDXHGSCbm3GXDo9M8WvnCBaHL2adVQ6yxC1wEC24CHHL2Q7hPyfXgrXPfg7fx0ed46+8iTRtoSf
	6eU0z0JJrpbxvC3O1/oKNQ+wY3jihcKqqW2QCt94uJ8hTJrD9RPYDSfX3uen8unUVZgGFjm1QyY
	gYGM+tn/0Okwy/9zq/bphNlbevZBmdj1TYidpEiiKYW3ES7yTez7M9FYS6E6Hr6E8EMk21lKOW1
	0xjr2hYTsMGMLpTmGmzpeigHp9RJj8fCBQ==
X-Google-Smtp-Source: AGHT+IGG/EyO3/Feq2JSm8JdT5erJOZMKomWfyb/sedjsQC3Ckswibh7fkaSk4cSaoPLMI5okE7+yw==
X-Received: by 2002:a05:6902:1501:b0:e5d:c321:79b7 with SMTP id 3f1490d57ef6-e63f65f3041mr7172755276.8.1742244917062;
        Mon, 17 Mar 2025 13:55:17 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e63e5554f61sm2394535276.44.2025.03.17.13.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 13:55:16 -0700 (PDT)
From: Sargun Dhillon <sargun@sargun.me>
To: linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org
Cc: Sargun Dhillon <sargun@sargun.me>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>
Subject: [PATCH] trace, RAS: Use __print_symbolic helper for entry severity for aer_events
Date: Mon, 17 Mar 2025 13:55:15 -0700
Message-ID: <20250317205516.599440-1-sargun@sargun.me>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The chained ternary conditional operator in the perf event format for
ras:aer_event was causing a misrepresentation of the severity of the event
when used with "perf script". Rather than building our own hand-rolled
formatting, just use the __print_symbolic helper to format it.

The before / after are as follows (and also tested to make sure
uncorrectable events) still show up as uncorrectable.

aer-inject was used with the following AER event injection script:
AER
PCI_ID 00:05.0
COR_STATUS BAD_TLP
HEADER_LOG 0 1 2 3

dmesg (unchanged between runs):
pcieport 0000:00:05.0: aer_inject: Injecting errors 00000040/00000000 into device 0000:00:05.0
pcieport 0000:00:05.0: AER: Correctable error message received from 0000:00:05.0
pcieport 0000:00:05.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Receiver ID)
pcieport 0000:00:05.0:   device [1b36:000c] error status/mask=00000040/0000e000
pcieport 0000:00:05.0:    [ 6] BadTLP

Before:
virtme-ng:/# perf script |cat
   irq/24-aerdrv     424 [002]   392.240255:          ras:aer_event: 0000:00:05.0 PCIe Bus Error: severity=Uncorrected, non-fatal, Bad TLP, TLP Header=Not available

After:
   irq/24-aerdrv     424 [002]    29.198383:          ras:aer_event: 0000:00:05.0 PCIe Bus Error: severity=Corrected, Bad TLP, TLP Header=Not available

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 include/ras/ras_event.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index e5f7ee0864e7..9312007096d7 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -327,9 +327,10 @@ TRACE_EVENT(aer_event,
 
 	TP_printk("%s PCIe Bus Error: severity=%s, %s, TLP Header=%s\n",
 		__get_str(dev_name),
-		__entry->severity == AER_CORRECTABLE ? "Corrected" :
-			__entry->severity == AER_FATAL ?
-			"Fatal" : "Uncorrected, non-fatal",
+		__print_symbolic(__entry->severity,
+				 {AER_NONFATAL, "Uncorrected, non-fatal"},
+				 {AER_FATAL, "Fatal"},
+				 {AER_CORRECTABLE, "Corrected"}),
 		__entry->severity == AER_CORRECTABLE ?
 		__print_flags(__entry->status, "|", aer_correctable_errors) :
 		__print_flags(__entry->status, "|", aer_uncorrectable_errors),
-- 
2.47.1


