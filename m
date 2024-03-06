Return-Path: <linux-edac+bounces-733-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63054872E56
	for <lists+linux-edac@lfdr.de>; Wed,  6 Mar 2024 06:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18EDB1F2766B
	for <lists+linux-edac@lfdr.de>; Wed,  6 Mar 2024 05:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD3717BCC;
	Wed,  6 Mar 2024 05:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ss2OTsBW"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9ED12E78
	for <linux-edac@vger.kernel.org>; Wed,  6 Mar 2024 05:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709703053; cv=none; b=AQveh9EkHTQEE1bPJlS4MeDIQD9m+E3FQ6Qryvn7sJcNlcU496lvcMKOgAakHDqJRGv10TumZpTa+5cmn2VyzSlveGsDkh8tZLpTrFKMmLER0Q/Z3c1bPYoonH+prVQK2rCK+E+iENb90He8FPwdMxo0kTTiAa57qhT73J5m7Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709703053; c=relaxed/simple;
	bh=OY98z60/QzvLbbjJJOeTrYBjG7cId8nlzWYX3q2YOzg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=koguKun9DZ/iWdqUyu5eZfyZy5pFS63TSg7W11em24m2BWj/krdBe9zj2Lx4zYnDOtWcn3KvgkRgbzA6CYwJ378jnKxUPeyp7Qfdte0R3yj4GLhNoUHMi9oTpEuMq6N0lDBovdUWK7ivC+aDGvwvfuJtdDqFkj5etu46VttFUTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ss2OTsBW; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-412f62ee005so1509715e9.2
        for <linux-edac@vger.kernel.org>; Tue, 05 Mar 2024 21:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709703050; x=1710307850; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CNOl498zVyqa8QNphWPOEGcqb03+QO3BzSaHzQ2kTRc=;
        b=Ss2OTsBWOLOVZ8wXUd8p0cgQFMprlBmnOgJAK49pv3Ptjf9za4+uY0go53tpB6zJwI
         7QlHLjxiPk+on6xs5WcS2z66voO/sidx06UxJ/bBhsvOXMfxr5Vw+7WimQKz6JsGcKML
         7QvN9JU5sIWtC+Wk8aj7yATii+8AyfaV/t90009ddIWqhUBsKfdXJhtV2Jkrj2W9nOBG
         fgqg22Ja1kDD8eFQTi+YSBRnPes0In5rfcDXShCUlktmKCQEj0URIBoBK1wAuSpOGGd+
         QF5QhLIdKgCBeD4bfDuGtEyOTELmiXt6YXuXPeqk7YOgQDn3aaRluUaEFruvBkAdug9F
         7xSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709703050; x=1710307850;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CNOl498zVyqa8QNphWPOEGcqb03+QO3BzSaHzQ2kTRc=;
        b=YIk9ZoeAhLl9Tr8r+rkQOEbHxMvV4qahv5xgaTIwkl+y4NOub4l2iXsKJCvKfxpEiN
         RwUKLGyEu8ywTSNXxBQGg3km0AJO6qN94pnp7Ot1/d3kFnwbSealNWRAEktEAe74zNWu
         Y2zc6AKyrBT5HBYG+B7w29i2QlXKpmPZwjNP97pv4Qan0g62clvgtECo0JKqF2kn4xZ1
         by2RCR8ajr/yvUsM99rbaN+wYj56USHWrccyCqdbg8f/VclirOLF5f28QL8rziRZJ/R4
         O192X7vM3T58QmUJLiZ9B7XbqKIOQ9fnZcnm7GkpV9NyrMV3vldLqGlZUNYpyn8y/PPP
         wxSQ==
X-Forwarded-Encrypted: i=1; AJvYcCViA6+8PdyI4oTRONpir8tLIaeEDOt3315Usn7jvY8EOrbZAnqocoakRtlUrmdJVXILZAw3k2dPgcv3J9ukNrcgUgCbBS9SAwIkJw==
X-Gm-Message-State: AOJu0YywmvcBQOjSXjeHbRl9TipXW2+25b/7vuPH683rs4KSjAAty9Yr
	MKscDM0CPvHd703cSkbSDo0PwQL7r9f1Mp7Rw91PxMFFI79FQh0JtsUqjR8TkDE=
X-Google-Smtp-Source: AGHT+IHUD3k4wXBn/nqincbWXBgb7lYot4qWLOwu90kC6NiIRRaWqliTeBdnFMWQzdTP8Ja5lYSwZQ==
X-Received: by 2002:a05:600c:3596:b0:411:a94a:1ee with SMTP id p22-20020a05600c359600b00411a94a01eemr12189693wmq.21.1709703049710;
        Tue, 05 Mar 2024 21:30:49 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id be15-20020a05600c1e8f00b00412f6c695d1sm421000wmb.43.2024.03.05.21.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 21:30:49 -0800 (PST)
Date: Wed, 6 Mar 2024 08:30:46 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>, naveenkrishna.chatradhi@amd.com,
	muralidhara.mk@amd.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] RAS/AMD/FMPM: Fix off by one in error handling
Message-ID: <6fdec71a-846b-4cd0-af69-e5f6cd12f4f6@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Decrement "i" before the first iteration.  Depending on where this fails
it could free something from one element beyond the end of the
fru_records[] array.

Fixes: 6f15e617cc99 ("RAS: Introduce a FRU memory poison manager")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/ras/amd/fmpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
index 0963c9e7b853..2f4ac9591c8f 100644
--- a/drivers/ras/amd/fmpm.c
+++ b/drivers/ras/amd/fmpm.c
@@ -817,7 +817,7 @@ static int allocate_records(void)
 	return ret;
 
 out_free:
-	for (; i >= 0; i--)
+	while (--i >= 0)
 		kfree(fru_records[i]);
 
 	kfree(fru_records);
-- 
2.43.0


