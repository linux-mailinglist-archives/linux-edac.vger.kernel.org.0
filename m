Return-Path: <linux-edac+bounces-1303-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF6C90CF10
	for <lists+linux-edac@lfdr.de>; Tue, 18 Jun 2024 15:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C8E02825AE
	for <lists+linux-edac@lfdr.de>; Tue, 18 Jun 2024 13:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF7B15B10C;
	Tue, 18 Jun 2024 12:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OkW05z/u"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28C115B103
	for <linux-edac@vger.kernel.org>; Tue, 18 Jun 2024 12:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714628; cv=none; b=jUy+fRYP0cs4b8cbd6UsDKFDo3I4JuIF+Fy8iv3HH/X9ZzATs3zKzWqi7gkkIr2ZUR45yaxEaVh4ZbHwizKY6koUX0zbOpfk4wWps7sFuj7ylmVxJsD36uMX2I+gMywbeaIU+pM7IscnA8cpMbWXXQSU5zH0rlcklG1MEgLXawo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714628; c=relaxed/simple;
	bh=UHMPlHtbeyyrNAG0OnisM7LplQJW51WSkzDmixlhxj4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oEY4Oz5jRYn6UCjJxgawqexjYp5nn24QitFiERpz6G+xt/6vzwhfMe7KCNjNyEExoaj6jhXbJtngN8xA+5c3xDwVAgTdMNQLrsiGJwO+DI6QNlWXj63B2kR+K64B+TJSHFi4VxXXwFyKAy/IDDcE/dZYOWziJk9fgLzbWNksOns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=OkW05z/u; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2c2dee9d9a1so4432560a91.3
        for <linux-edac@vger.kernel.org>; Tue, 18 Jun 2024 05:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1718714626; x=1719319426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r3yZnmFzbpO425MPYTnvkQiOaVw0tQ0ZTD7yM0B1TMw=;
        b=OkW05z/uoRZuAEKHq9+oR9/dnzHnPdq4Pcm8ZzLELESv2ADF5cOvHiO1glJd+kYUA8
         4bPG+fxJFn0jm8rp3P5ik9bveJMhA245BxSwN6KSy2iPMjMnuAFGFl30pS6P/QCc7D7O
         Kl0+CxzznDnWe7r0aYN6rfI+djYOgsbpKSIXqDCcjihqAmO6j7D3aS5ipS2WYW+UtjEX
         pP2uT3PhR6bB0XgfsDWGIob6eFa95REzMyUaJqJ7sCkMOfoCD2ASHeV+Lw3MFkXBFqkc
         SoCsVxpSVE66Hb8rsx30cirkCzFBNC28xdQD34y+9cqvsyVieqmbRQKrn8xsQrlGF7RS
         1RZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718714626; x=1719319426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r3yZnmFzbpO425MPYTnvkQiOaVw0tQ0ZTD7yM0B1TMw=;
        b=stdPN4O76Ie/oHuG90xsaZYosVv3uOv9g+cGsJBu90Cs8VkgDv25TVmoAvUXxa9XHZ
         uBgShoZoOn/OFVTQv5Bztosu2ILy7ErlUy2UH0buw6g+SLZbBYwpNYBTqQKZCNzfcluO
         5ELItbQqZNg6AspPTH1+AwRCF5XkHoRz7cxMRx3YL7aUnKS/XQRCryNVF85n+9hEzfdk
         jWMoPvekNH1bR1XW0xgUIOjE+odGcUd+fCp8trW29BEWK8JW7I24dZVs5weAbjBEm5Ob
         NQdIKtpQwyoL6sdlBHpbeIQ1Hxgu7yQtAwXJC0/f/Ww3698iI491tsmeDVhpY5jhXkVo
         Rehw==
X-Forwarded-Encrypted: i=1; AJvYcCXTSTuuy6eMas7cIvk+cc+yiGLKITPRz/1Lfl3pKVen/nPjrzTmSvI37WgpZHbsPIJnhQC7Trh8MHsOgpXLKlc0Ws5F9XSAG4fVUQ==
X-Gm-Message-State: AOJu0YzeV/+4HIlpIY5gkmgl/28+BfE1CXRgsX+TK4rMyATJ/kxYSuDY
	uRJ5TDNVGTAYutkc1/hqAVlYZmmPjpsye35v+tqJ9mQewR7BONXVAQbZoBGY4NE=
X-Google-Smtp-Source: AGHT+IFeHFXcuqstqyBLWlQRtxnbaBhgqUio80BDkhNMsX7J0QkYUKFFquz3vdD9VkFXH1M2344CLQ==
X-Received: by 2002:a17:90a:a607:b0:2c2:d6cf:f4d2 with SMTP id 98e67ed59e1d1-2c4db44c393mr12369580a91.26.1718714625799;
        Tue, 18 Jun 2024 05:43:45 -0700 (PDT)
Received: from L4CR4519N7.bytedance.net ([203.208.189.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4c45ac600sm10864198a91.5.2024.06.18.05.43.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 18 Jun 2024 05:43:45 -0700 (PDT)
From: "$(name)" <qirui.001@bytedance.com>
X-Google-Original-From: "$(name)" <$(mail address)>
To: tony.luck@intel.com,
	bp@alien8.de,
	tglx@linutronix.de,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	hpa@zytor.com
Cc: x86@kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rui Qi <qirui.001@bytedance.com>
Subject: [PATCH] x86/mce: count the number of occurrences of each MCE severity
Date: Tue, 18 Jun 2024 20:43:31 +0800
Message-Id: <20240618124331.12729-1-qirui.001@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rui Qi <qirui.001@bytedance.com>

In the current implementation, we can only know whether each MCE
severity has occurred, and cannot know how many times it has occurred
accurately. This submission supports viewing how many times each MCE
severity has occurred.

Due to the limitation of char type, the maximum supported statistics are
currently 255 times

Signed-off-by: Rui Qi<qirui.001@bytedance.com>
---
 arch/x86/kernel/cpu/mce/severity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index dac4d64dfb2a..a81e34c6e3ee 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -405,7 +405,7 @@ static noinstr int mce_severity_intel(struct mce *m, struct pt_regs *regs, char
 			continue;
 		if (msg)
 			*msg = s->msg;
-		s->covered = 1;
+		s->covered++;
 
 		return s->sev;
 	}
-- 
2.20.1


