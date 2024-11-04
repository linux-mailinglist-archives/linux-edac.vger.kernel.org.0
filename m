Return-Path: <linux-edac+bounces-2418-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3749BB4D9
	for <lists+linux-edac@lfdr.de>; Mon,  4 Nov 2024 13:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB13D1F22098
	for <lists+linux-edac@lfdr.de>; Mon,  4 Nov 2024 12:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34D41B0F33;
	Mon,  4 Nov 2024 12:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aiven.io header.i=@aiven.io header.b="GWWQCx9x"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80B718C025
	for <linux-edac@vger.kernel.org>; Mon,  4 Nov 2024 12:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730724177; cv=none; b=ldUdI2760tWjNswo+AXauP6MyOMa/qqsXeFGA969oOfPcmJZhIEBzqaY3hG3grwFSDHLAsiBBow1yXxXjVoPt7nj47AmjwRVMw+sc02fP6btSZ368+7Wb4MCGUB605fGQHnLN2n0Pi2nUJduMAeSu8nfaZUWIUHhu3CjV4yHaIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730724177; c=relaxed/simple;
	bh=IPvEnzYv1ZCXrN2PlDfCL0rkSO3hxGvJg6ElxwVmFAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DV921S+Imzx6N/gw133IxdHvddCTieXZMYUPpqD0jqE57sfSxGCwZUeiMxD4MegFQNQxRV5AJJbTsvGr2j9NQZ8X0S0GPHGlFUUTJodF1K3xBC0eTYS+npIoPngsoaHMzErUvyhlOCsVGH7L1MhHvVZEQiPrH4H6sAKp45mdF+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aiven.io; spf=pass smtp.mailfrom=aiven.io; dkim=pass (1024-bit key) header.d=aiven.io header.i=@aiven.io header.b=GWWQCx9x; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aiven.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aiven.io
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53a0c160b94so4617481e87.2
        for <linux-edac@vger.kernel.org>; Mon, 04 Nov 2024 04:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aiven.io; s=google; t=1730724174; x=1731328974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IPvEnzYv1ZCXrN2PlDfCL0rkSO3hxGvJg6ElxwVmFAg=;
        b=GWWQCx9x7VNVu9mVmfgTVzDD/BMqt0tSa2YdYsCErxfpl0Qw+HNetInL2jy2f906Jx
         1LemAUeExhvDlZ4EU7NpEanZNftEseqwFmjXvEEtgt0rrooiAJPctlwClhmFyE4ciQTl
         3F6f2F+qwBfb6RpV5QKF0uxQRhhSddA5Rralw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730724174; x=1731328974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IPvEnzYv1ZCXrN2PlDfCL0rkSO3hxGvJg6ElxwVmFAg=;
        b=j+pK7U5KGgNQmkwUBLBMD78/drRws/I28xuIltI5995cgSeYG6LT64lGTg2ibk1cEl
         UVqXVpTGZKj6ZE7DCcxTYn+dJ8r0WzdXBC3uv+P0s+FMQkgvrM+sFagqn6W81CP8A/g8
         Tp1YkjDXaQl5P/Zxz7b4A5VxZXxvBKVP1kKaLsyd/kg8OxayadAXwNv6UVB2M6w9qfxm
         wCXkhA7L353ZwAbto6RsTE7oHrTEsXDrB1K73AdztRFUU66zvoNqMedje4JZyplBoONO
         uXGhbr0TGP3lXN8kj7EvgF37nHNE9MPdSZphpuH8gq7CKYJl7CjvsEVbplfIPa+e07hE
         EbTg==
X-Forwarded-Encrypted: i=1; AJvYcCUd/GCbQQSoPvEv1z315bQdYbsAvQbsSPDQH2+BEbNfDtAlBn5g1ZvG/R8yfIxz9xSzfDms3/lFykz+@vger.kernel.org
X-Gm-Message-State: AOJu0YwdGNLRdvWp8h9OzwO/on0zA9jNW3sMNKpk7ytguizSGYWZP8Oe
	rKLvWQrJLPVgESnvpvsKLLCAVDM4HRDuWvShHWGBYndrnUIiqcttjt4DaFIqjzY=
X-Google-Smtp-Source: AGHT+IF9JIDhBxE4JO9TsU9zUsb+lHX1Ew/DDycr5M9Wq8vjS+4XfXIXAte9E7LEpHb0iSTZfAqgYg==
X-Received: by 2002:a05:6512:3d09:b0:536:9f02:17b4 with SMTP id 2adb3069b0e04-53d65e1abb3mr5805002e87.40.1730724174024;
        Mon, 04 Nov 2024 04:42:54 -0800 (PST)
Received: from ox.aiven-management.aivencloud.com (n114-74-229-70.bla3.nsw.optusnet.com.au. [114.74.229.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057071fasm60567525ad.84.2024.11.04.04.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 04:42:53 -0800 (PST)
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
Subject: [PATCH 0/3] EDAC/igen6: Avoid segmentation fault and add polling support
Date: Mon,  4 Nov 2024 12:40:51 +0000
Message-ID: <20241104124237.124109-1-orange@aiven.io>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Qiuxu.

Thank you for your help and guidance. Here is the updated patch set to fix
segmentation fault and to add polling support.

Patch 1: Avoid segmentation fault during rmmod
Patch 2: Initialize edac_op_state according to the configuration data
Patch 3: Add polling support

Please let me know if you would like me to change or improve anything.


