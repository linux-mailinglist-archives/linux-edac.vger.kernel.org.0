Return-Path: <linux-edac+bounces-2403-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9649B9996
	for <lists+linux-edac@lfdr.de>; Fri,  1 Nov 2024 21:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EBE51C211F4
	for <lists+linux-edac@lfdr.de>; Fri,  1 Nov 2024 20:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FEF1D9A57;
	Fri,  1 Nov 2024 20:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aiven.io header.i=@aiven.io header.b="MgVFTrxO"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7054F1D0F49
	for <linux-edac@vger.kernel.org>; Fri,  1 Nov 2024 20:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730493753; cv=none; b=RyJJ8bAT0vUfImEqiZDHQ82LIyR+XybowhaVMD3sqU7tvzeL3K6OMhtJKDAT1ymfneIymvqGG6946UD2ZZraz7C32QgQrYIOz4bM4TXNUKaV9u5xokYwqFN+mKFSnPDNFH4zeYfoADpLyNuyvWc+orS0dmqZDEdgzURUpC+EmYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730493753; c=relaxed/simple;
	bh=kGTmaZ8VYBva1ZK8P0FOfYrulH2hJ40jqcGH9FPdzKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WwfrsVUkCNcraJHQYCNpPybG0YlvP4zxdKOL6rp90l7xq6rAJcK59bF4QkLCXE52NLZ6cyP41rGh1sXQsBkP76R9cxSYkVoVXzG5W9hvfaoQwknM2csJ/39zmkK8dZnCmSnfJ/FvKd2yahwQRPJt1gRlqh63p+Khkabi4cCLXnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aiven.io; spf=pass smtp.mailfrom=aiven.io; dkim=pass (1024-bit key) header.d=aiven.io header.i=@aiven.io header.b=MgVFTrxO; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aiven.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aiven.io
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4314c452180so20798195e9.0
        for <linux-edac@vger.kernel.org>; Fri, 01 Nov 2024 13:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aiven.io; s=google; t=1730493750; x=1731098550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kGTmaZ8VYBva1ZK8P0FOfYrulH2hJ40jqcGH9FPdzKw=;
        b=MgVFTrxO0jdnA4qPbaTUI60B2/3o4nFRIXdYQ93khw02qFjg8dcVuPREoMimHBZLlZ
         nfgdLWW8tEJeOeveoHFHN7t7pzZLodyLqc5vojc/N5s+GINniba17Qx0FxUifQYatQKI
         hrpN5Fg4ROTDpJNKh4KvkQDt+YVPRgQFTDj1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730493750; x=1731098550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kGTmaZ8VYBva1ZK8P0FOfYrulH2hJ40jqcGH9FPdzKw=;
        b=KjG6RF156Lq13P70CjpC+JrFsQPJh4mmwgljjupoVkLwbeYra5+jEHaUd/GRep4fxj
         fFg56Qa2EC4LVbJC7sOUa98QMFDLlkZWExwxi+f/Llo3E9/UNLTeKype973kbGqrzfg5
         WuU1/SCnFgl5NrgBi1U3mMWpPr1Chex/M1I2HVQCykYQUZ1snnWw7/oEnuyEZ/kYioUn
         nIYUgNp5eR/PbtcgJMf8b5Bcxt1I6q19E0LGMjLP82lUvC/P8VOnEiW2RxLVbTzpZhma
         ngkdqi9UxEeTYL7bqg2lOAMp5JR/Z/NH4GRgroX4HQqrZnCHy0IZ8ZsrTRIlzCULD1DL
         tg3w==
X-Forwarded-Encrypted: i=1; AJvYcCV/GLCx7FW+X4l9Xwnwf0jXMihz7Onwr0ny7Na3pSJEitBvmIV6drXMNBNUq2KDIVUvoHblkuPr7Llw@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0dqgpyOUM79Thr8fEqTTk5A6hY2HFWTn2UkwKuN3jr0bXPGaI
	AiPxScmPvqR05NmFIvCOS2aTdhC1iXXCiTKRiHc/+w4UxZ0T9xHgJJsFN2IC3sU=
X-Google-Smtp-Source: AGHT+IG4YReyiic/m8tENyXAEwrMNkq2OLZQ8QQm5oE4rkpnsmxNvEgR400p0RVB+YD5mceFaOgWZQ==
X-Received: by 2002:a5d:584f:0:b0:374:c33d:377d with SMTP id ffacd0b85a97d-381c7a1c51bmr3994044f8f.28.1730493749725;
        Fri, 01 Nov 2024 13:42:29 -0700 (PDT)
Received: from ox.aiven-management.aivencloud.com (n114-74-229-70.bla3.nsw.optusnet.com.au. [114.74.229.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056edb4csm25014455ad.58.2024.11.01.13.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 13:42:29 -0700 (PDT)
From: Orange Kao <orange@aiven.io>
To: tony.luck@intel.com,
	qiuxu.zhuo@intel.com
Cc: bp@alien8.de,
	james.morse@arm.com,
	orange@kaosy.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mchehab@kernel.org,
	rric@kernel.org
Subject: [PATCH 0/2] EDAC/igen6: Avoid segmentation fault and add polling support
Date: Fri,  1 Nov 2024 20:41:12 +0000
Message-ID: <20241101204211.414664-1-orange@aiven.io>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello. This is Orange from Aiven Australia. I want to propose two patches to fix
a bug that affects my machine with Intel N100.

Patch 1: Avoid segmentation fault during rmmod
Patch 2: Add polling support

The detailed reproduce steps has been documented in kernel bugzilla 219360.
Summary below

I have a PC with Intel N100 (with PCI device 8086:461c, DID_ADL_N_SKU4 in
igen6_edac.c) with a BIOS/UEFI that allows me to enable IBECC and error
injection.

Interrupt seems not working in Linux, but it seems able to detect the error when
"modprobe igen6_edac". I am not sure if this is a BIOS bug or not, but I have no
access to BIOS source code. So I tried to implement polling, and it seems to
work. My proposal in patch 2.

Also "rmmod igen6_edac" can trigger segmentation fault. It seems caused by
double kfree on the same memory address. I tried to fix it in patch 1.

Thanks for considering this. I am new to this area so I could be wrong, and I
might need extra help and guidance.


