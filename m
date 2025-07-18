Return-Path: <linux-edac+bounces-4387-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E7CB09A3E
	for <lists+linux-edac@lfdr.de>; Fri, 18 Jul 2025 05:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9218E1C42FD4
	for <lists+linux-edac@lfdr.de>; Fri, 18 Jul 2025 03:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAFE1C84BD;
	Fri, 18 Jul 2025 03:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="SCU5+M4o"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0290070825
	for <linux-edac@vger.kernel.org>; Fri, 18 Jul 2025 03:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752810415; cv=none; b=b+FYfefFGS0pC6c2gQzCmHTSOpA9DYLu6cwjhXzz0SKNv4qjXC/NIslwthSiaokVpSr6HgyL9NgAM5+VCSL/6x8ziQy4Bgs8F6PeiDrQGqcIDgOjT3Tt/icy61W1GQrDmoMnl3PJJzR4ZKZiMHQR02sow5R/e0Q81nK68jZNb/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752810415; c=relaxed/simple;
	bh=Mf9215EGCTrmzHCEhlJE5KvEgKqe2O87UjIpxFAjudo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KCo7ecQmtFu9V3OX961WEhVGgKgOaG4vVOEiN3eqweHkKg00IBaRa/Syn47Mqzf7o6fYXYmcfDA4UuoefM0WqJX2i+xOL3nieKPqPS4jn3YuXhfyCa/zsFt5lOeE1MdfTmegXvBW8HsPWr2Iej4H0iI2wEkXw+xBy1gzAZcMDm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=SCU5+M4o; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-748e81d37a7so1157371b3a.1
        for <linux-edac@vger.kernel.org>; Thu, 17 Jul 2025 20:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1752810413; x=1753415213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mf9215EGCTrmzHCEhlJE5KvEgKqe2O87UjIpxFAjudo=;
        b=SCU5+M4owUAq67eGL2xlpSBkeKyUhA8Kq6XFmjO1BLZfka8BYKq+K2rc3Bo9ToKIwY
         rXa23Ds4JToursaj7bEhWeibslzDKQNPDMK9HM55mwP52A+LNWvPuhu52cS+KJm7pnCw
         Y+pN3TUF31U/sgTLEBooIErRvCdG6EXB1KlyT3JZZkBwIyXw0y/HkjBkUlRDj48MFEjZ
         g9hJxDdDlA695w7GTsRlviDeMJzVfasC4u48WhwQ/I1JCI4ZkvuV8ozlFgJh8fl1j2NA
         Ku2F66+xxyXEupdjqYNtkdqa3JMYqYPyA38a5sEuX32XOVMl5ZJi01rjj8Bo3ruXNfbA
         6s4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752810413; x=1753415213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mf9215EGCTrmzHCEhlJE5KvEgKqe2O87UjIpxFAjudo=;
        b=VpbxkFAModtzrCWwUGYjLWHd08GVhilVJFX53PMTMIIVAPONz3qT9gNSNddPK9xY/8
         sLoItoqZySCnL3dECzCw5aVFDV2+qw+aws/0BxWKybIce9zkIL/3rNnYggcd5hZLkQ9x
         DUicaWJD99syFEDCLvnttbIKtInTwsgeND0iMEvtwl5hHgnrMkv6JoYZKvzomrO0TynC
         +VpmY77glv2LSqBL71Xkbncw8awHMS/ad9i0ZDLqwu7a65qlkzCidO/MwVCrMtXbSBh+
         AN2VRn5STI7fw2rqynyYWqfH817+xXkhbA9Rqcnb63uY0GcT9iHrPBCAkrwdtBvdMIRg
         euyg==
X-Forwarded-Encrypted: i=1; AJvYcCUR1KoijRGQ/N1HEf5aidoVTErjyk01kegcurPRjdHkzpWmoT4C0Mv0gJz0DM9LFV1al26W7UyqfvZY@vger.kernel.org
X-Gm-Message-State: AOJu0YyabNriOhZa8bqHBRRlRNYMaG91DzUquhaEwrgd/P5/wHPy3lB+
	ESj3BzIUVAbT+hHowGNISKmmJcoivDbZbphpJogHMYZCtlPSJiSm0jDXi4dutMjgv0HnqEmmQjy
	6blIW+L0=
X-Gm-Gg: ASbGncv1w3X5SEH3eKKS+7K8syfvI+j65pZIHE64qeyg3SN9wpknZl/FqqsHebB5Lvc
	xSKcvdGl9bDv63X/CiM7HJuifPaU7G26acLC8Tu6lLJuRw7EW1VRcd77Ql6+90P2vKF72HXSWPP
	SzUlOda3SmJIRmjfQY/XHJPb5CAtYvvwAmTGXvUBxjHemvacraIVP3RZzvuylXvmZN/wUdFL/lY
	y7Z3UPfPchqh+lhM+/3LaT4L9Ljm78EhVRFItRcYqVrn17FQSY6/jc6/ncuNyRiNGCAn5Lh+SNu
	qIOoqwKQ93+iS1EngFCn3XpL5TZKBS+m3JVJ6ogHBAS2jhBJuesbk7n1dhbMDbwpxALhpsbqfbY
	oI4aA9rS4hsNqakgNA2PuDmjqkq7lCY+He/HJ2UyoXbdIO5rs
X-Google-Smtp-Source: AGHT+IFNa+EcH83FNXnjEm3C0F6TihGjOc1OMxlRUqkqp/V85onlhfwD3tW3WOOTiHm6RK2tC/cZPA==
X-Received: by 2002:a05:6a00:2189:b0:746:27fc:fea9 with SMTP id d2e1a72fcca58-759ad4002fdmr1963419b3a.11.1752810412983;
        Thu, 17 Jul 2025 20:46:52 -0700 (PDT)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-759cb678d8dsm310811b3a.110.2025.07.17.20.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 20:46:33 -0700 (PDT)
From: Matthew W Carlis <mattc@purestorage.com>
To: helgaas@kernel.org
Cc: anil.s.keshavamurthy@intel.com,
	bhelgaas@google.com,
	bp@alien8.de,
	davem@davemloft.net,
	ilpo.jarvinen@linux.intel.com,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	lukas@wunner.de,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	mattc@purestorage.com,
	mhiramat@kernel.org,
	naveen@kernel.org,
	oleg@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	tianruidong@linux.alibaba.com,
	tony.luck@intel.com,
	xueshuai@linux.alibaba.com
Subject: Re: [PATCH v8] PCI: hotplug: Add a generic RAS tracepoint for hotplug event
Date: Thu, 17 Jul 2025 21:46:16 -0600
Message-ID: <20250718034616.26250-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250717235055.GA2664149@bhelgaas>
References: <20250717235055.GA2664149@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jul 17, 2025 Bjorn Helgaas wrote
> So I think your idea of adding current link speed/width to the "Link
> Up" event is still on the table, and that does sound useful to me.

We're already reading the link status register here to check DLLA so
it would be nice. I guess if everything is healthy we're probably already
at the maximum speed by this point.

> In the future we might add another tracepoint when we enumerate the
> device and know the Vendor/Device ID.

I think we might have someone who would be interested in doing it.

