Return-Path: <linux-edac+bounces-4831-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3B5B8489F
	for <lists+linux-edac@lfdr.de>; Thu, 18 Sep 2025 14:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E7E41C00039
	for <lists+linux-edac@lfdr.de>; Thu, 18 Sep 2025 12:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C971C5486;
	Thu, 18 Sep 2025 12:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RJfTU5E6"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B31138DEC
	for <linux-edac@vger.kernel.org>; Thu, 18 Sep 2025 12:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758197838; cv=none; b=SdlVi7bsH3B0O92HvXkpEECF3iZaidy7o4/4WBmsYXPtZJDYUVnHyauW2oo2oH8D4UET7t2M4NS5lf3+W8Guu/I9bow2OPz8CY1fFoZm1WmrxWVUXGrK0/JcRxvWQq6QXww3a5ZkLu0OsK0Yg+ByMIMBynISTW+dbOh+c36dNaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758197838; c=relaxed/simple;
	bh=3HTdFHE1nOnlBuISAA1vPVTn99dilijNsc7PTZ/Rej8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QI56rHmiUenzPHfpctN66NeybxWwG8t6CHC0VByF4RQb8O8CqLZeJriLLw0OvkiS5Oe7ppEd8gdQGfgj6Av2vcQrOwd9/lc5K2zqozVdm4T3/7GhyOsXHQRH/sBjf70h7YK1or4uWUkv/CBSYGDilwAv8qhTcScoHJh9umYURfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RJfTU5E6; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-77256e75eacso841670b3a.0
        for <linux-edac@vger.kernel.org>; Thu, 18 Sep 2025 05:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758197834; x=1758802634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jatDnkKAY0zA3/egfMgLsSXpfyI9PR3+CVwZCbKLIFA=;
        b=RJfTU5E6HCbEvFZDmlZyUaFg7a+olv/lbMXcGLtj6ZGbtSdGcA+q617+1FRBVJxHvC
         cWet5jXlMZ/Zd347fXruZNKUWL+yltUU0cOdJow5VdpejvNYqukq2ooZBfirV0omu9xB
         LRF1m6a5DG1WGLaK5uT8y2roqglZVVQri6HrTlBafnWMT3BptW2C8NL3OHFlgMA0bEmE
         KATQoYrt2iJt1mYCjpxzWJsRvvnuxd+NbV/IJpF3WZ6NZiDMUbsYZfsZr64J4eQpBeRT
         66LQJSbJdgM0I8YD1gqAwpO1Qfi2BlaLHlpr+Oz6HuX25WiFz6emzkMoagX/pJ9vz895
         Mwkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758197834; x=1758802634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jatDnkKAY0zA3/egfMgLsSXpfyI9PR3+CVwZCbKLIFA=;
        b=kq+aGqb5P5IMete+5HIN3kiUlMR8c9dJjCRgjv1kOkHpJHwqkeoRZZ4LZjim3JV1Am
         pGftDQyNq+ANTnzq708Ioqha34yJSM5+dZYYQPn7VGo7VCXmMuUgY6pOJlot6yY6eWnq
         xBog9AFbR/Hxa1BlVFg/RP56DeGfXEyncZslMCpj6soZng/4+UZAS2WK+1j8A1EpN3LF
         S/YDl5NfLOKU33vNL2qoYlp9RScxwlSgwSsz26+wf1MDD7W5I0wkCLIRarUAFiccLO4s
         ENEYDpI8anxSiMun2EwjjMdt6ROFQlEcQUBt+FI5rHMqKBP+nEhFz5JN1kD3PLTfEiE9
         i+yQ==
X-Gm-Message-State: AOJu0YzBViLAVUHRJlvhAQHwjfdob5Qc0lsQj8lxQxma64NSCb9WRNWR
	6BUeaE+gxl9XeMqXQymCsksx+99t7vIulN/rrHXRlvN+OUuxeeZoBmVEnt2vet6aXcE=
X-Gm-Gg: ASbGncu3FQT21SEx2MDwxX6vvmMUarg8kp2LO6UsFiPnw42pgzJnNRJDIxMq99nl8Ki
	o/twghHFOLTlGJgxLdWOcVFLyTn46/OKEMxK+mjQkPclz7xPsDeJK6mqp6PVBLdW+kMAIb59EVg
	yFlzTHsEyS0X1bVs8t91I9ZQnvFI4o13C5K4slfUTYpi9D6gGpjGcD+/Dbes1LPpPtoKIcb9gsy
	bvgtCAFjRqkPqepu+/M7sXdCzgJcJEF18dXCsBW31/WaY3V34uTcipOdNuTcoPxi3suz4o9BExe
	6BarrNwJY+Bpum1B2TEU3KBcYgX35RerLhzPjVWfnWxrh0UDZz+xE0fkdo89Z8PRrqy8JbH4l+y
	TtnzBDBJiKr+JPZ2QpRXjxvpS8d8pESs31AK48/KhJO3DCIzN7Q==
X-Google-Smtp-Source: AGHT+IG4rqckA4W7pc4nGdg3+s4HGjiQFkvQqmFvGUjzXj+OKrljgWz6KGWOYSNvOTvazqcm9w16Og==
X-Received: by 2002:a05:6a00:18a1:b0:772:78e6:f61a with SMTP id d2e1a72fcca58-77bf71cdeeemr7119344b3a.13.1758197834388;
        Thu, 18 Sep 2025 05:17:14 -0700 (PDT)
Received: from L4CR4519N7.bytedance.net ([203.208.189.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77da44030besm1168023b3a.0.2025.09.18.05.17.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 18 Sep 2025 05:17:14 -0700 (PDT)
From: Rui Qi <qirui.001@bytedance.com>
X-Google-Original-From: Rui Qi
To: tony.luck@intel.com,
	bp@alien8.de,
	mchehab@kernel.org,
	james.morse@arm.com,
	rric@kernel.org
Cc: linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rui Qi <qirui.001@bytedance.com>
Subject: [PATCH] EDAC/skx_common: Fix allocation check when adxl_component_count is 0
Date: Thu, 18 Sep 2025 20:17:04 +0800
Message-Id: <20250918121704.45116-1-qirui.001@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rui Qi <qirui.001@bytedance.com>

Use ZERO_OR_NULL_PTR instead of simple NULL check to properly handle
the case where adxl_component_count is 0, which would result in
kcalloc returning ZERO_SIZE_PTR rather than NULL.

This ensures correct error handling when no ADXL components are
present and prevents potential issues with zero-sized allocations.

Signed-off-by: Rui Qi <qirui.001@bytedance.com>
---
 drivers/edac/skx_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index 39c733dbc5b9..768d787813ec 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -90,7 +90,7 @@ int skx_adxl_get(void)
 
 	adxl_values = kcalloc(adxl_component_count, sizeof(*adxl_values),
 			      GFP_KERNEL);
-	if (!adxl_values) {
+	if (ZERO_OR_NULL_PTR(adxl_values)) {
 		adxl_component_count = 0;
 		return -ENOMEM;
 	}
-- 
2.20.1


