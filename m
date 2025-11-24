Return-Path: <linux-edac+bounces-5512-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A91B5C7F21D
	for <lists+linux-edac@lfdr.de>; Mon, 24 Nov 2025 07:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 53D7F345FBD
	for <lists+linux-edac@lfdr.de>; Mon, 24 Nov 2025 06:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE062DA760;
	Mon, 24 Nov 2025 06:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NTWT6iad"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DED241696;
	Mon, 24 Nov 2025 06:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763967460; cv=none; b=Zl2YF3C+8Bu57urM/02jT0jzrKlSpxBNoxjyvEXN9YcUwebU+3pr9i+E+fIqTGMVYhQXWsMImCIfNxAB8h0eItGs1mRBlCWmd7Ek3GqMOTDgCExzQ93rBla4pB31+At1delDOPCpVRir4YyQIlLzBBhM6En3kJ4WPzD6FlVAKjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763967460; c=relaxed/simple;
	bh=aum3SJzPqXcRSquTZB2vXjOpy3RVs2jSO5UhtqhM0s8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pk/K5SZpv9HUR2Jf+hC8b15eP2wPgwGl5MP9GPHQ5jDvO9uW/SAhnKj5W3inr1TMDNPXmnSUUDJ1LxmcKyWo3cBXepoHh11rGJzW2EdvZDEmfyULNabz+6zmG0odWCp2wK4/6znUn9l+D6hJrc/ivTB2xrBHdcyoGSIDC+5VIqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NTWT6iad; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763967459; x=1795503459;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aum3SJzPqXcRSquTZB2vXjOpy3RVs2jSO5UhtqhM0s8=;
  b=NTWT6iadff63b5cLDInR+V/OtuFpKItX7HLJirQxUD0UopW1pvwOqWQ5
   TkEa10+hjqB82/r1GtB2lbwGwKKteR/O7iHVLWsePGmoBAVAjta+wB3Ww
   Dghgks/zZAgzHkl2VEIg2egffcynJBoK6ATxlmN4yZSkXfNczUQy7rxmD
   CyONnBRoyBpx+CP1ejKjp7Ya9BHXKLWsZtnAcdoj13EQJeXXCIq764Zx+
   X8N5Nb0h1cb/g+8/Kv1EwZIAR/MaOlizXzZmaRFn9cedas2Rg6yyuhOqa
   81TeAxD3DcwhYpbXA9XLwTrQ0KWWHCfAWQ7RtEEjKMzMX5RIN+j2HWnnd
   A==;
X-CSE-ConnectionGUID: o1VRaPPYQlKvsfvfgNGJvw==
X-CSE-MsgGUID: yOOOT2p4QOeewtHOSduG+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11622"; a="76286863"
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="76286863"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2025 22:57:38 -0800
X-CSE-ConnectionGUID: 8TyXG3OoQqCcyH9c40UBhw==
X-CSE-MsgGUID: y9sbfSZ+SXuLOXdp5ltsIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="192272766"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2025 22:57:36 -0800
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Yi Lai <yi1.lai@intel.com>,
	Jianfeng Gao <jianfeng.gao@intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] EDAC: Add two Intel Amston Lake SoCs support
Date: Mon, 24 Nov 2025 14:54:55 +0800
Message-ID: <20251124065457.3630949-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1: Add IBECC EDAC support for another two Intel Amston Lake SoCs.
Patch 2: Configure masks of four memory controller registers properly.

Qiuxu Zhuo (2):
  EDAC/igen6: Add two Intel Amston Lake SoCs support
  EDAC/igen6: Make masks of {MCHBAR, TOM, TOUUD, ECC_ERROR_LOG} configurable

 drivers/edac/igen6_edac.c | 71 ++++++++++++++++++++++++++++++++-------
 1 file changed, 59 insertions(+), 12 deletions(-)


base-commit: ac3fd01e4c1efce8f2c054cdeb2ddd2fc0fb150d
-- 
2.43.0


