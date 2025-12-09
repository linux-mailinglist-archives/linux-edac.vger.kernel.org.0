Return-Path: <linux-edac+bounces-5555-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA49CB04C5
	for <lists+linux-edac@lfdr.de>; Tue, 09 Dec 2025 15:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF129303E65B
	for <lists+linux-edac@lfdr.de>; Tue,  9 Dec 2025 14:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C832FDC26;
	Tue,  9 Dec 2025 14:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gqEL6Cvv"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3DD2FD69D
	for <linux-edac@vger.kernel.org>; Tue,  9 Dec 2025 14:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765291021; cv=none; b=iVYwBjW5MM8NDac4nsLoZugYs1IQqR0RONE5G/ldo91HR7kJXatQTt8CDL4RgYN9SQFyYIAuyJY7V1RM5hGz0ORdP74K8APr9tJhUst/3eMM52LU+AAkVO9C60gL5rQAEVPSiSTX42va/HXWcb35MovSzXBg6K1wi3g/dJybAKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765291021; c=relaxed/simple;
	bh=gigxiRC9Oq3Iz7xLQZNdO17IWGA0WTGkm82otVibpcI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HojhuhzjTQquw1UvdNw2x2vITbYYsSY8mZbRp2kquBQc+uhwRuzxS42qrXKQV6RzxVYQIhD4IGQRwhrKsn6K7b5GJhBcoTYu7BV271XI+LOcQ1ctbQocR6xf38i6gv8B8rOmdWhBcccDaKMloNYQcMoNOMBl6Fpf5oJxTi6eb8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gqEL6Cvv; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47796a837c7so51361735e9.0
        for <linux-edac@vger.kernel.org>; Tue, 09 Dec 2025 06:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765291018; x=1765895818; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rF4ekYwyUag3aCgdAzfcA4onkO96QC5ua20zsVNEtp4=;
        b=gqEL6Cvv6RABi2UThj1wtEeWpgtF+dF3Gx5NAQp4rBiPC3TI/H7QTxZtyB63dmaUVi
         /hTBbEJmakp4JLRMJFzOoduzL6hOEU2h2rQiy2mLbZq9YYoXL/HkiF0+rqgjnctIqAKD
         /A2y9cqZ3vu8fzLHgDLo2eMvp3YfxK23e9AH5mD5TfHM90u/8qoB99I53kSerjnsHOVa
         mOf/NmME2CN62XY7ZA8Hw38gRCnYl8+1smyGBzrOP3Jeu4Z9z8CNR14psh4wRgLIyqi8
         eVbwVc+8Fn2PNVCLvez+Yn2iQsLCGzASQ628wYFt/ubCwY40AwtpzSn0gqNdgr+I60Z9
         p0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765291018; x=1765895818;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rF4ekYwyUag3aCgdAzfcA4onkO96QC5ua20zsVNEtp4=;
        b=oJnD1x/HR3KAOkvPRNIw3Ok9dCPtu2Oc4y8JVsfjIwSWz8XBouvDQ6dP8PA93H0Oum
         SR4dLJOlle6HHGsHNy9KZHqaE0vSmeLlHdg58vgroLL40kdCzr2ataGAO6QVuWUnLAo7
         tSJB1OUZGK0RE++lC6zq8DHnR5h0wF1u5yEMhCN2yEt5NFD/fOMUvOTXFB9AKRVY2gOp
         waMOfWLWPZ2K3/aeBhM6ePConqRFVvPHRmGmh+6Qsmc6IBYSqOM8QKSjQKWJNQiPpOfM
         0teN2k1eAU1j6zKEXCGRs868+cMdQjVKocU6KuhW6n1COdytMSsLE9TE6n6499gaoMW5
         jnOw==
X-Forwarded-Encrypted: i=1; AJvYcCWfAO5pyYCEdDZoUaOMyX3GzmrO5JaoVI5TsmiQiY6RY2UiOBAcV7akyIgOp/SfMlKKoHLFgqpm+KPv@vger.kernel.org
X-Gm-Message-State: AOJu0YzTvLADieNCMCiOo6peh2OelhJY4Tk9V8FQFPUAnQXWBh9n5Mow
	JnCCYMFRWuuhTozsNJLRnrJ4tS3+U+8jOS1b3TQwqdhL26uGeDqjzA8kPabJfS9rx+U=
X-Gm-Gg: ASbGncvXTWgXeJCxsKBcOYgQtCsxydsoT99Wu4j8VhkAquUg5fx+fsS3P5CCIgVVmWP
	UrgiodcHHtTR86myDsFyns2z9OJ91/pLAp9OSCdY7BjbRh9wikE2Fmcr0gutSWz3mpvJVJGCjD9
	Dhnrp1Ynti1Zmh2OvtB+5mVFYf09sfiFmZf6ALwdC1Q/92/TptxAbfkpewQpsvARY+jvBDnnUHm
	Wr6DYcdDDJxTYvMGePDlcKQb1jfI2CuzHBo/XU+YmhgMweFiCKn5eoweRdGYfNOMg4WGafygM8U
	cSVFqlQZBNam0NCSS67uQnG61AAVTdN7F5e3RhiQzYHRCfU44B9jLkFu8E0mYVeSEce39t0oItX
	Z37Z+mQ6gCSWnD5NhPml0eOWKvQb8Zg9chyHNjya0PVOoT22tZvtwWnOxb5DVkizPhJS5HaaIpO
	lqCsW+o9lt93Fsj4ya
X-Google-Smtp-Source: AGHT+IGOd46f0YmeidNlJHtP2zOoYmP4I2ymnUChshe1Rk+Ep1tSUOIHbWUkmtX4JCEiTrSuge7Wcg==
X-Received: by 2002:a05:600c:620f:b0:477:994b:dbb8 with SMTP id 5b1f17b1804b1-47939df6abcmr102888945e9.11.1765291017620;
        Tue, 09 Dec 2025 06:36:57 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a7d696a57sm42856645e9.13.2025.12.09.06.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 06:36:57 -0800 (PST)
Date: Tue, 9 Dec 2025 17:36:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Aristeu Rozanski <arozansk@redhat.com>, Borislav Petkov <bp@alien8.de>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v2 0/2] EDAC/ i5000, i5400: fix snprintf limit
Message-ID: <cover.1765290801.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


These fixes don't affect runtime since the buffer is large enough but
the size limits used for snprintf() limits aren't caculated correct.

Changes since v1:
* Fix i5000 as well.
* Fix the subject
* Delete some related dead code

Dan Carpenter (2):
  EDAC/i5000: Fix snprintf() size calculation in calculate_dimm_size()
  EDAC/i5400: Fix snprintf() limit calculation in calculate_dimm_size()

 drivers/edac/i5000_edac.c | 1 +
 drivers/edac/i5400_edac.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.51.0


