Return-Path: <linux-edac+bounces-3534-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C72E2A88777
	for <lists+linux-edac@lfdr.de>; Mon, 14 Apr 2025 17:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A11D172F3C
	for <lists+linux-edac@lfdr.de>; Mon, 14 Apr 2025 15:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DB8274FE7;
	Mon, 14 Apr 2025 15:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="HHJtgGjE"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2361C275861
	for <linux-edac@vger.kernel.org>; Mon, 14 Apr 2025 15:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744645122; cv=none; b=hcr/OABXPIO6QCtWCp074t4Z1NE7tczEwXI3PbY05YdDnVTdfviccnI06F49uGirnaxmGZObGTJpG2S4J82INFbylLrlZGhDAP3E8+vHAnboitXFXT2RLRTnEy3XpzlPdpdo7960S7hKzN18Kp26LpNwY+S/D4Y6JbCT6N8bhRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744645122; c=relaxed/simple;
	bh=QQWrFCU0lxYwyZvkufIrKpj9QZGeF1jQQqxeadFVPSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VGM539IETRnvIs8FzsE3p/2a3tZTBSWUMYMQOeadGsCJU42OWCV2SrYJkf+cBm3iH7yqZA1j0H1zk4DwOPwUp7tDom4G6DzNuypK1FGtsCF1Wvv7knVRnZQ0bbq1ldYZOGYVPWfjpn24eCdseLvpXhOWuHbM/+xG/uoQA8ccsq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sargun.me; spf=pass smtp.mailfrom=sargun.me; dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b=HHJtgGjE; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sargun.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sargun.me
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e6df3d5f596so664417276.1
        for <linux-edac@vger.kernel.org>; Mon, 14 Apr 2025 08:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google; t=1744645118; x=1745249918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cg7wm1gQKxPnYT5N6cnKLlagimUWPqnH4hJORex0FBs=;
        b=HHJtgGjEv06ipS7G0Ge46lVbecHEBRJSmXdDLuOmcl0FpN/pv+Jt2h+bBmYx/vB3fp
         PtEXqMA78ovGjreYYK9OtDhRweY+eAX+wmRJ1o+UPBRnStwQQWa+kGnnKP0jRYgp1cij
         DAyqzayBxZryvTfZX2hrp0/jZfUGVGWyEm3Ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744645118; x=1745249918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cg7wm1gQKxPnYT5N6cnKLlagimUWPqnH4hJORex0FBs=;
        b=oNHPuJSCrfFfySoxZPudRnYJHulX4VcviRnjA1p6wAG5h4vUt6mfhf6F8BtkW76eYK
         tKTWiRO/MxBz9qRy5NsvSFuoNLMBnY6UXWGq7LC4vwtlCiTYyNJTcyOkVG6FnZuLbECl
         GVTtZ/3niq+N/e5n49+4pPz9ErqQMgrI9r2nPEd8iZlEcJENwH0JgGpxRSSkHM/y8T1o
         SyjOrnCNIofndS4X6jnAqCI+yBFnDCkLg7DNE9bSj5Ae0EIgr9/373W3bTFTfOlwhhqS
         MaHL6BUyNRDBydJA0VLAr5khVkQg3eDu39LYFHq1yhEtSLeENgcti7Ic0ntTypiH1rif
         b/oA==
X-Forwarded-Encrypted: i=1; AJvYcCWaTb4Vcutxx5jlLufog5inTtCXZd0GQu1tbI93QHEhK+940sAOhROmVVPjb6yA3khesXCYH+LSPjCj@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6nEls5WG5HrOIz8QKVZFj70Ury7mQV7sm1PPOQZwcQ/LNDWSy
	B7jt4NlUebPvv2mp5zMw8ewWQPHQixWNm7FAvW/w1K4w6n+2sWEUfde8e+0GlNE=
X-Gm-Gg: ASbGnctGuUyzh7iW2swbqBba64F54Nto1M8v4enPTW90o1u5Lh86WYHgwcjkH2APnio
	GNlLeaEzj89zNdU7d67sDOH9jrYoCeoE6TJKcAncoe4fMWR+zlpYKm+ZJi8WXP3PhCRbiDncQG8
	tcwq1Ns88iH2PQwOPlBDpPHuOvONyRMo9Km2l0BdDSIXBkLGBZc+wnpDTD+Ef8jCfdH+qICMqPF
	WfWU559S995wkEpEwUS8FVLHftMTMdr9kRdqkWdrhQBKmjy2NO1qjAYJUFOG2kt2VlTxZEYlnSp
	jM6Y6orlYLifIUwjNvTmRDR5ATIKEQ==
X-Google-Smtp-Source: AGHT+IFXaJHA4jn4texV8xgFTA2mT/ZVZHNvt7z4f2KvUDw2pLx36QdW+AE9X7ghaoCnIgTjMYyeMA==
X-Received: by 2002:a05:690c:d94:b0:6f5:be28:632c with SMTP id 00721157ae682-705599965b5mr95917727b3.2.1744645117480;
        Mon, 14 Apr 2025 08:38:37 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:8::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7053e11d349sm31264617b3.43.2025.04.14.08.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 08:38:36 -0700 (PDT)
From: Sargun Dhillon <sargun@sargun.me>
To: linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org
Cc: Sargun Dhillon <sargun@sargun.me>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>
Subject: [PATCH v2] trace, RAS: Use __print_symbolic helper for entry severity for aer_events
Date: Mon, 14 Apr 2025 08:38:34 -0700
Message-ID: <20250414153835.947207-1-sargun@sargun.me>
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

Specifically, all corrected errors were being formatted as non-fatal,
uncorrected errors, as shown below with the BAD_TLP errors, which is
correctable. This is due to a bug in libtraceevent, where chained
ternary conditions are not parsed correctly.

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


