Return-Path: <linux-edac+bounces-2556-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E78B99CFF98
	for <lists+linux-edac@lfdr.de>; Sat, 16 Nov 2024 16:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78140B23AC1
	for <lists+linux-edac@lfdr.de>; Sat, 16 Nov 2024 15:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE0613A26F;
	Sat, 16 Nov 2024 15:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwbuuQfb"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4612E80BEC
	for <linux-edac@vger.kernel.org>; Sat, 16 Nov 2024 15:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731771632; cv=none; b=gV7piUwA9XHPJj97sVxV5lyeLqGS8O0+OgbHvJHx0f7V+7gopsI8RuSgdAz+OMv8IEdOWMbJLb0vjNBhMHklLwoWbr5HlKY76DuY5PdMTmJuHgiehx23dAfJezXyvF0Z5ckUOBSK7D9SeJugLQn8hNIaymLnzHw+xxfMdyC1nGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731771632; c=relaxed/simple;
	bh=Wd+7kLQISUZlzyPvYmSUTVOb8NV4Vyd3OpsFXw6X7a0=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=F5mb3YLJJnosYAXyFXUCb9wiGje/sPm4ck20uqm5F1+ZW+P0cdYEVWHQuEtVkSAomvNEJVooGqjPtJI1deTW41v15IRw871tdxRi10yE4IMQA13RK37011CQpCoIhVn/9V5D61oyfNDev97CgiHYKNNo6H0/fMeGj5+xLJL6540=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwbuuQfb; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ea45dac86eso217961a91.3
        for <linux-edac@vger.kernel.org>; Sat, 16 Nov 2024 07:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731771630; x=1732376430; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHEOkgJ64rwJ+cv0sVIqPUmbc8l+iTifR7HzGzNced0=;
        b=fwbuuQfbAvIFDnvTqyswSlpt/dYgo8Gpx9pXIDrfv487/qNDlKRhEU7RrZz67d9hqA
         NMvvoJWqfsO6DpHJx18AuYE7jO7RnPgaD15X/ertJRYyKuPElJIfYRShzGIgKskA7Uhd
         VlbtQ0mAjcUi/uCn8w4d7ubZ0ANKPq1XcBj1cBNw+3JuCrFARF2b9BucnQKQUKPZmIJT
         4mPQ4gOxtpQvhOJ8B1+kmCfhIg/7l7lEhCzFmTwMejZmwB9JYkoy9/7ZW+yesfHZ2pQ6
         aCOW6S8iIs0sTzE/h896kNE4hXmcOecrF1d7WnXPN11OeN1PneHynz9DxvecWuWVyIOB
         NqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731771630; x=1732376430;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XHEOkgJ64rwJ+cv0sVIqPUmbc8l+iTifR7HzGzNced0=;
        b=OP78kOvhXm+YZdB/NjdSgfCUfW9GjCskrAzGL6UyjKJucDS/hwCq6/isVDnFNbGZd3
         kAGtb6F4j8/u+/LDdxrYnS4aJOGi15RjYb3e0t2LPR6AoJ1bR2mz4nR2ngPQlfCV2kK0
         i29/488rtiq2HQNHD1As/WxHuMlPnOBd3vBvKYhqG91Vq0RUghnEIBA3jNNRBW7uwPLc
         lj6jIy3me11ddZq1P/Sy5oIxznTjnltmr7P8snYWm7c8VL5yV/9k9DKDFPbhjU41zY4K
         Q8qHh1UsDlD9WNWNLglWJWH+SLaxdgV08cJWyraetmiqRSGMX5nX/EndUzl/BYuJI6qt
         uMcg==
X-Gm-Message-State: AOJu0Yz1ZLAW1paoGxFDEL+xmg6d9CzDt8YwUpDEysWKHi9h0F0lLO0O
	F8m87Iar45sE4kpvh4NrUKUeO9RqGCV7WYDEbEp3qMdeMtHaAgRqw4788A==
X-Google-Smtp-Source: AGHT+IG0h3xZGlIZmhboWcU4NVCtNzBzV8gY1/zOEoaXr14mAEIT+nBi8AO5+Dq7+G9gKOOsyYA4Sg==
X-Received: by 2002:a17:90b:48cc:b0:2e2:a029:3b4b with SMTP id 98e67ed59e1d1-2ea1556c981mr7239868a91.28.1731771629963;
        Sat, 16 Nov 2024 07:40:29 -0800 (PST)
Received: from [103.67.163.162] ([103.67.163.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea024949a4sm4635141a91.11.2024.11.16.07.40.28
        for <linux-edac@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Nov 2024 07:40:28 -0800 (PST)
From: "Van. HR" <vipinrawat07674@gmail.com>
X-Google-Original-From: "Van. HR" <infodesk@information.com>
Message-ID: <0adf78ff24f8074c89daac667ce89dbe09645c06f891952d48b407ebd2727246@mx.google.com>
Reply-To: dirofdptvancollin@gmail.com
To: linux-edac@vger.kernel.org
Subject: Nov:16:24
Date: Sat, 16 Nov 2024 10:40:26 -0500
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello,
I am a private investment consultant representing the interest of a multinational  conglomerate that wishes to place funds into a trust management portfolio.

Please indicate your interest for additional information.

Regards,

Van Collin.


