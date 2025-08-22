Return-Path: <linux-edac+bounces-4646-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CA7B3222A
	for <lists+linux-edac@lfdr.de>; Fri, 22 Aug 2025 20:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CC8E1D647FE
	for <lists+linux-edac@lfdr.de>; Fri, 22 Aug 2025 18:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0992BE7CC;
	Fri, 22 Aug 2025 18:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="LBwwXIJ0"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0758B1C84BC
	for <linux-edac@vger.kernel.org>; Fri, 22 Aug 2025 18:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755886535; cv=none; b=elEgTc/GVT7jgYjVdsybkj/b+t9l0dTaLsrt+yOuzQweJy+BS/J5u8Kl6Qt8HnrCLm3wcBFow077BHuqZi36ho1udXPeZzAkthNUgT8nVxnMiwpbFe4YK38uqdqSaxZg0bRRfHfF02IXVi+EIhg8chsUR7/+AX18ltO1T4lKtcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755886535; c=relaxed/simple;
	bh=V94dfA16La60dmKehf08TTEBcoaCXjBACbj1AhKkruU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HtfO5ayeMQTDsTI5uXEGqwgayUQEkEnnz+TmlNnzoYvSoHDagOpBkGibV0pUovEvV+W+912cKOAjnQfQuVNKvj3OfchgTqRucx/P59tletXediNBxeY4Z9FCG1RYnMYZVKJJ4D2581oMDg3mxmoGbBEckb39fjlvHsr3jaXMfkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=LBwwXIJ0; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afcb7aea37cso316894466b.3
        for <linux-edac@vger.kernel.org>; Fri, 22 Aug 2025 11:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1755886532; x=1756491332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYWGWVCN0O70uGnBCPPQFCaIo3hbXhoMScsfqxRs/Kc=;
        b=LBwwXIJ0UcKfsZ6Fn4z7xbi0+AkXaoPoT8WJHBeVUngWegUr8qwNsXZ8FtEJghznX5
         Qi/K2L5EogfbxdnzItAPc9qh4Z9zDbTZjfnUAc3JJ3ysTq/OW+N9Lm/cEwshCBkJ8KgF
         aI0xJdoD6vfoPvKXk0Ztl2JLMMEpXXFPiZdKAkKcmaD0kKJ/zZF8KBJQa3GLqFgcIMZF
         FyBjQJbu4gjGx7Bmj7xoCMqOohmb1v7Tc5+0vno5kYGkEOREWvyoz6U3jmG0njuxeHbE
         n8ojF8pvjXjzpRzSzwHCfiADF/uVH/mOUUj+syX6OpDqbuTx10pi2pRmyot4qbKahSy6
         NUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755886532; x=1756491332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qYWGWVCN0O70uGnBCPPQFCaIo3hbXhoMScsfqxRs/Kc=;
        b=JRKgaKJr5ZNJTkkSnxJvLLkRkmg8sfKU5Cs5JRB3iQ54VUuVUCfYsB1uUdul7rHVbv
         WJbGTvOdEiJfJwysGD/4w8RWYLZiZJSHHLDpK6mG85CDwkDGOljJGp19dCg5G6nrtNzw
         GDUzPdN66ekNi+pcCs8zsB+z7iuE2o9KbRGSZUPHgtVpLnx01+dQYHi0FavFlcBN52pZ
         Yx6TPg+OZ/fShQFvlWW3PieS0+lRYEfDVzibjnqyvkzEa+KNXfeFUN4ysX0ZA94HZUqo
         /j6ZPXU6TxdopMzjG3KQzTVf0bXSAmDpEvgqFtz+/G0njkdX6WqWYqhslVUKKe+VyLzv
         YOtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXb0h81w1X/uU3qqp031NI6/8NMYCVLfDaEKm2Wrm2mkdrD3jUa1W1os+YsPJxh0icNuVy0JF2i0I+f@vger.kernel.org
X-Gm-Message-State: AOJu0YyrRK1A825PI9D588FtwQsltORrjju7OmipulJX4Bmfz0jJM2bl
	t3LCgZIANsMp+fU2CHBh/qVoNgUFqkFBLY8wrJW4km8vxzTyusYLDnXZwHHkiK6TgcQ=
X-Gm-Gg: ASbGncvWFHpEnb0Dfy3gXxy0CecpHz82RcH/uvMxBL0fAhO0Y3Lxn7AsaqKeZ3oF7no
	DnM2yCVpbtr2aLyCRnqrsnpUJRxngE+3fe7AvDXFALqXHZvAMiSLHPpuzvWPMgn4gvpdVZpxeJu
	tqUJO8fZzW4E2lcSETtn+hqDB8kHMkDM0ICLaWeFuknZLpHLdP172LRC01qAwX2VxcqweUj1v2O
	CNVNuM8XQ5HYXvd6lNGHKXtxAy+uNBlvbWze9dCM3Kb7DniiEJQ8h9lxqB+fCvddIYXIqqZKPKH
	0YF55a9F/YEp7mqffWWa4JhTmjBD8C7cHbS0zQDEvC4EdSr7Z2z+T1CDb5lhV4YU0yTf/xzMaXC
	8EWZnCJ+ZubVXEZAqMPNidbqFuiKi1FNdEARjfEumAGjPm69hXSYMTAnq4tI=
X-Google-Smtp-Source: AGHT+IFi/UqB7Uldrm+9VbwlcvS/K9grf+HFQGwUPWY0Y+SNRhjWVo0c6zi2HNxzYpUPo9jAOLRO3A==
X-Received: by 2002:a17:907:7213:b0:ae0:d798:2ebd with SMTP id a640c23a62f3a-afe295c0e07mr334350266b.35.1755886532255;
        Fri, 22 Aug 2025 11:15:32 -0700 (PDT)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-afe49314f63sm16474966b.97.2025.08.22.11.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 11:15:31 -0700 (PDT)
From: Matthew W Carlis <mattc@purestorage.com>
To: helgaas@kernel.org
Cc: Smita.KoralahalliChannabasappa@amd.com,
	adam.c.preble@intel.com,
	agovindjee@purestorage.com,
	alison.schofield@intel.com,
	ashishk@purestorage.com,
	bamstadt@purestorage.com,
	bhelgaas@google.com,
	bp@alien8.de,
	chao.p.peng@intel.com,
	dan.j.williams@intel.com,
	dave.jiang@intel.com,
	dave@stgolabs.net,
	erwin.tsaur@intel.com,
	feiting.wanyan@intel.com,
	ira.weiny@intel.com,
	james.morse@arm.com,
	jrangi@purestorage.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	lukas@wunner.de,
	mahesh@linux.ibm.com,
	mattc@purestorage.com,
	msaggi@purestorage.com,
	oohall@gmail.com,
	qingshun.wang@linux.intel.com,
	rafael@kernel.org,
	rhan@purestorage.com,
	rrichter@amd.com,
	sathyanarayanan.kuppuswamy@intel.com,
	sconnor@purestorage.com,
	tony.luck@intel.com,
	vishal.l.verma@intel.com,
	yudong.wang@intel.com,
	zhenzhong.duan@intel.com
Subject: [PATCH v5 0/2] PCI/AER: Handle Advisory Non-Fatal error
Date: Fri, 22 Aug 2025 12:15:20 -0600
Message-ID: <20250822181520.12394-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250822165112.GA688464@bhelgaas>
References: <20250822165112.GA688464@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 22 Aug 2025 11:51:12 -0500, Bjorn Helgaas wrote 
> I'm terribly sorry, this is my fault.  It just fell off my list for no
> good reason.  Matthew, if you are able to test and/or provide a
> Reviewed-by, that would be the best thing you can do to move this
> forward (although neither is actually necessary).

It seems for pci there is always a massive list of things in flight..
Difficult for any mortal to keep up with. We pulled the patch into our
kernel & have started testing it. I'll sync-up with my team internally to
see exactly what the plan is & how long we think it will take.

Cheers!
-Matt

