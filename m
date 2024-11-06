Return-Path: <linux-edac+bounces-2457-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9249BE5C8
	for <lists+linux-edac@lfdr.de>; Wed,  6 Nov 2024 12:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7297D280CB6
	for <lists+linux-edac@lfdr.de>; Wed,  6 Nov 2024 11:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086FD1DED66;
	Wed,  6 Nov 2024 11:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aiven.io header.i=@aiven.io header.b="J9u4KoBu"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143B857333
	for <linux-edac@vger.kernel.org>; Wed,  6 Nov 2024 11:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730893261; cv=none; b=uRvQFMc6bsVIJEYPTVXfAPZa9Yuywau2e2eZmENwjIad43OOr9Wu/I+XUKKng1f8F2BVBruKtK2nU1KyLTXvzhy6tP8yzvKe9lgufgGPWagalZQS3dm2wcLB4sn8Bs242W0Lb8E8CCsRXvrrPJ3be7H+mZr9PQEj21YzR92I0qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730893261; c=relaxed/simple;
	bh=lR3BHzYJ+UyV5g9B+Lpd5GZdOu4D7coiM+7Iq9nUw/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f1Nj85VZsKOnl+lLnSZDoutCVuMsBRTedbu7itlt40GgA6XVWdlH4jJ4vZTlPaGteRxRoOdcJsRKU4kNGjeJeIxiDxRe4hPRWHrSA8EFFS1L13J56sQQvgohdTMdWc0D/2jx6Nitlh53l9rX/Ss4re5HzV+rCqGf7QM/0xTQvvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aiven.io; spf=pass smtp.mailfrom=aiven.io; dkim=pass (1024-bit key) header.d=aiven.io header.i=@aiven.io header.b=J9u4KoBu; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aiven.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aiven.io
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539fbe22ac0so6652847e87.2
        for <linux-edac@vger.kernel.org>; Wed, 06 Nov 2024 03:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aiven.io; s=google; t=1730893258; x=1731498058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ySISSvlzxGmhoArGiKFmusnd5mBhAFrK+lrvasOrzrU=;
        b=J9u4KoBug/iW+3tmd4aho9CTqL+2qTUSky8XchTKsjhELKtlrmHIu9Eyz9gZPrEnsb
         KXkoqCsP1w5dizeHaBUxANWFCQCr70k3laR4o/kYO1Ex0KnNvW2K4lCKyc32I36GoEaQ
         Bq4R+roe42KcUvyX2pLNPG9QPAR6izBl/CLVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730893258; x=1731498058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ySISSvlzxGmhoArGiKFmusnd5mBhAFrK+lrvasOrzrU=;
        b=TuAPMF59Jw9souPI7lMnvLmG7ClcS/KUZ4jANGBhlVXf8422Mbohk7kvqh7rtfdWyi
         ot9HN+07/YycDvWPvuFQ/BnHDa+hCMomWu9tiyhgFW3z4zsJELqS25jh2Jz9ezgWFbAu
         j9YvDpZdHAJZJAAOgiivupWUz2eudNsyCRhJM7E/dZyuI9ZQ/rp+N1rBrqPU6aE0AfLM
         IXxkiD569Fkd1Ic7pzy4xHl8XIb6QGlXEAOYHmh3RPWS2Fgpt6vPxMYmishNhkCxXzvH
         F1va2wDeYiveAyKOqTLz0nKWZAgFV8o6Kfwd+ZwMJUx552tfXIPyX4BICHFCO762noTi
         4JjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWD4+QxhLW1TgbjrP7GWGAUPELvWYsKFn3jWvZqYkQ9T3YtNcuGmBMm91c9fXmW+BX30E6JOrs3vZ+l@vger.kernel.org
X-Gm-Message-State: AOJu0Ywic+3WIY5YXUOvw9Rs1bEn0VqagDqaO6XqykCAyPTMp415o153
	AKagGoOwCT5nzxSq/Qe3G54xZ0G0aCfnSgJnrP1Br9RvieWsQ+1VWQaVUew/Eks=
X-Google-Smtp-Source: AGHT+IGCHVL6P1HXUIFeV1W/f48tEQy51ZzoJzKtvWFdHm5yoh0RdI0mYxcLchXItqfbpw/xnKBozQ==
X-Received: by 2002:a05:6512:398d:b0:533:711:35be with SMTP id 2adb3069b0e04-53b348e154fmr20203489e87.26.1730893258143;
        Wed, 06 Nov 2024 03:40:58 -0800 (PST)
Received: from ox.aiven-management.aivencloud.com (n114-74-229-70.bla3.nsw.optusnet.com.au. [114.74.229.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057d3f87sm93796755ad.249.2024.11.06.03.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 03:40:57 -0800 (PST)
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
Subject: [PATCH 0/3] EDAC/igen6: Add polling support and allow setting edac_op_state
Date: Wed,  6 Nov 2024 11:35:44 +0000
Message-ID: <20241106114024.941659-1-orange@aiven.io>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you Qiuxu and Boris.

Here is the updated patch. I would like to propose that we keep the 
edac_op_state as a module parameter. Because it would allow users (regardless of
CPU SKU) to test different options on their machine without compiling their own
kernel. I hope this could lower the entry barrier and make it easier for them to
test IBECC.

Patch 1: Initialize edac_op_state according to the configuration data
Patch 2: Add polling support
Patch 3: Allow setting edac_op_state

Thanks. Please let me know if there is anything I should improve or if anything
does not make sense.



