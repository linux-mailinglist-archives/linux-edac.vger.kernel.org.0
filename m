Return-Path: <linux-edac+bounces-4321-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AE5AF90FD
	for <lists+linux-edac@lfdr.de>; Fri,  4 Jul 2025 12:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04EF01CA3813
	for <lists+linux-edac@lfdr.de>; Fri,  4 Jul 2025 10:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2DE2F362F;
	Fri,  4 Jul 2025 10:55:47 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BB92F2378;
	Fri,  4 Jul 2025 10:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751626547; cv=none; b=Mp232E4gD3JCDI37AlnPxQw8ONGDVKb+nklR5d5XojHnENNQbJ6fs/1Gd6Zy04voJTBhm+d8VFoZYarizgGMEjoLxs9cn0n38KKDkRCs0IqtXPWN/SX35zIFfofCv+47VoeN6i6j9busHVNuONSzbeWzaqhxgUKCTr12Tr4b/2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751626547; c=relaxed/simple;
	bh=OfZxMm0wtJ0u/hEKScgSTDyZshlYtHfsHkORSdK9eEY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WdrbTXZLgQYNPZeA81dbyeQp0g9yU2J2Vfh2I3aCFmi9WKsVXGiSMEALYU0HETeElZL5Yvbj97YimB9ClPiFGcIj0l9vg7NuC0g4lB+DYwaSF9QW6BPQtWX0PbL9Lop9vRxjmK5kP53WeKx6WIZCtdHeaFqD4gvMh5dGpZYOtHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-60c3aafae23so4217701a12.1;
        Fri, 04 Jul 2025 03:55:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751626544; x=1752231344;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zXhjbBQxPc41dmIg6kX1o57348NlT6T9Q+QljyaNGuE=;
        b=nRa6QHMJQvKeTgkYDF1rVBzgOzx8x41gUIZ7niddJeS3NvU2/xMVSil0eaYilGfaRd
         5FYX7rS5keJLNSsRqzQUNZ/9sGEvWvgIm+Gbpmwt5K1BldFaV+fXXAjV+LAAUSXGhPw7
         NbrGEjDK2/cIUMtvSgGLiVbXfdPOGvM2fdGJcEClktrSiqAtyIBiF2dz08EtCTY4F4zy
         bOMsG4Ib5PdvNls6QYPE1zIFJxz9e7EbTKZ4TPR+nG+FMlzfP5F49VFnVEraYQVS6y5V
         gqwLVil3HaG/ZTu6m1BGMWm/D3tlch2j+WeboxKAfztn9TTy2WF1PlGZ4I6aAz+t+V4A
         UjiQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7DzLcvEyVJJIm53SV4taIzo7GRMHXQw7cikezjA2+3Cj931Vl3pXNA0xYS+YnzwdbLS1UkVL7swj+Dw==@vger.kernel.org, AJvYcCVGYVbEx/1OzaakNmHBN077aa8VuzIjj88TQIbsJAiAnvSpnYbNQ2XV0hKrtmbVVptqajNRh3eEk4qY@vger.kernel.org, AJvYcCWZQfy3DJaqRUJFV8KJDdqDvkFM26zrL2jlfcgEf8/XAkkRWdvvUhYrnWCIO5Z7aIlVdBrigqPKIVIamHmo@vger.kernel.org, AJvYcCWi0acyCmgJqIUcWXYtv0YvUEXEkd6M9hI25bfsE4+Z7w7mFbibkhXFIgiQS5zKEtVBE/TG53RSq6fK@vger.kernel.org
X-Gm-Message-State: AOJu0YyfYbNpcngqrX9sYZH3bsEue02kTpRoIbXBiDZkGlsmuTiIYtA3
	WRNGlKlKIJvL85aPDBPj5KQUm7pR1Wh7y7GaPwovph3P50lXrz2HNOXU
X-Gm-Gg: ASbGncsfNu+DQVMAqFHPesHqAHdwJneh4oRP+xTfOrGs8AlI4UDCzYv+JrrHGDpNOEv
	ZeZRRHp2adGlRbsGc2Mvmhj8QRAfZs1Nin7buLcCh4fVjkfMWfpC6vu65TeKUU1e8JoisEUTjzs
	E1Rcnf1NpRb8RFIYo6qc2PPgGaprKBK9MVw8zzhANW8jhpJHQ3nomELvI1ehCZ5719fuxlxTvD3
	0Lah0zB4+OuBrX1Pfxgzr4c6GglSVfX7+imPZ6rBFXg6ABe8gV/2fW88GBGpjctNQ4vgoAWX6T+
	TWsW+WiAn35JYWeVjdpZq5GEtz4GJl1wjYnEVRXgc3ANq476mLYx
X-Google-Smtp-Source: AGHT+IFtecnxFxpAEi73VQ7stv/WU5mZI7Q3B3ULoJe26MN/qhHXGZTHEmxxv8nFLd24f8A1QAm6Vw==
X-Received: by 2002:a17:906:fd87:b0:ae0:d409:5f19 with SMTP id a640c23a62f3a-ae3f8021712mr265754066b.2.1751626544193;
        Fri, 04 Jul 2025 03:55:44 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6ac373fsm152691866b.79.2025.07.04.03.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 03:55:43 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 04 Jul 2025 03:55:20 -0700
Subject: [PATCH 2/2] acpi/ghes: taint kernel on recovered hardware errors
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-taint_recovered-v1-2-7a817f2d228e@debian.org>
References: <20250704-taint_recovered-v1-0-7a817f2d228e@debian.org>
In-Reply-To: <20250704-taint_recovered-v1-0-7a817f2d228e@debian.org>
To: Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>, 
 Jonathan Corbet <corbet@lwn.net>, tony.luck@intel.com, rafael@kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, kbusch@kernel.org, rmikey@meta.com, 
 kuba@kernel.org, ast@kernel.org, linux-edac@vger.kernel.org, 
 mchehab@kernel.org, bp@alien8.de, linux-acpi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1398; i=leitao@debian.org;
 h=from:subject:message-id; bh=OfZxMm0wtJ0u/hEKScgSTDyZshlYtHfsHkORSdK9eEY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoZ7MrtRmjW3TJIxqrt1/Zwjaj0nvtpE8DseDjZ
 c65ogrhs2yJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaGezKwAKCRA1o5Of/Hh3
 benCD/98A+Zy6cEraPLcV/ZuVANE8SzjYuc2VCeS+ELaHyfugQzeQ580nf2Yo7PYEoE9UpaFLg4
 zsLbmgdazNLnFatAapInAOckQ4L4tozwKnyWFvZedlCst+HNV2bxXNPskiArA0svc6j2z1rhlhP
 k0ytX1N7IYK17QY8cdNJz/Wf/ppGsVm57cJdV9I8RFOfhhz9MD4d7zl4Gxsmlyyb+o9y8MUqwh+
 qvlBpBDrxk7106JgZw4CrKK2n1Fo2IxOsMLqlz1Y2ugWCL26GKxinkgJXv+ExI14Fu494Z6vJGc
 VnNF4ESpY1rgpJuguAGF+mP69cTVk14dYv4xsIum5R1AdTXmmkH6nCMSr920UAOS0vxVBQwzoTj
 I51KEXsl4djmGg+5SWHhQDSfdnV8VYHBY1GjP/tW5DkV8wl6qHTAMFhPHJvUcK2f6ec9yONImmG
 w5Rw2jrmbFZc9YmhWCafYBqiVAUIYPTVRx4wHjk3SwMv0MmBkk3E43N024oaqD3RuMFXAdWqJAP
 WyV1zMXsdmhWIMngqvwxhFuxnHUPKzg/D/JUlo53m2AuMuVod6R513rLl/Naai/ShErRnepNvhm
 U90GiYgI4N8U3eLXLG3RqRSMrIxdZEBx2ikbNM2iak/YmP42EInvlIB/nNU8y0WY+LIlKxA07lo
 s/uVeBkBiAw8Sug==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Update the GHES error processing logic to taint the kernel when
a recoverable or corrected hardware error is detected.

If the error severity is GHES_SEV_RECOVERABLE or GHES_SEV_CORRECTED, the
TAINT_HW_ERROR_RECOVERED flag is set. This allows users and support
tools to identify systems that have experienced hardware issues that
were recovered at runtime, improving traceability and diagnostics.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/acpi/apei/ghes.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 3d44f926afe8e..f323cefe234b9 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1102,13 +1102,16 @@ static int ghes_proc(struct ghes *ghes)
 {
 	struct acpi_hest_generic_status *estatus = ghes->estatus;
 	u64 buf_paddr;
-	int rc;
+	int rc, sev;
 
 	rc = ghes_read_estatus(ghes, estatus, &buf_paddr, FIX_APEI_GHES_IRQ);
 	if (rc)
 		goto out;
 
-	if (ghes_severity(estatus->error_severity) >= GHES_SEV_PANIC)
+	sev = ghes_severity(estatus->error_severity);
+	if (sev == GHES_SEV_RECOVERABLE || sev ==  GHES_SEV_CORRECTED)
+		add_taint(TAINT_HW_ERROR_RECOVERED, LOCKDEP_STILL_OK);
+	else if (sev >= GHES_SEV_PANIC)
 		__ghes_panic(ghes, estatus, buf_paddr, FIX_APEI_GHES_IRQ);
 
 	if (!ghes_estatus_cached(estatus)) {

-- 
2.47.1


