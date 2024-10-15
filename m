Return-Path: <linux-edac+bounces-2067-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB67999DF7D
	for <lists+linux-edac@lfdr.de>; Tue, 15 Oct 2024 09:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69A6DB21B69
	for <lists+linux-edac@lfdr.de>; Tue, 15 Oct 2024 07:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7405018B478;
	Tue, 15 Oct 2024 07:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dTYPdepI"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7B79474;
	Tue, 15 Oct 2024 07:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728978289; cv=none; b=lbdGLeiZwamQShynYk7DDtEArUFNWqYnWQH01RNM2P/4DOATzO6xDRWp29V/ozznrbe3ozd0GUQ+T0hLvkpKSEW1Np4PCmfB5OL07jz/ckYjIAa3hLxxgwq5un6q5vZJt+yaslw73Gzm/JS9AAB3gB2rsLG5jixxTbDxPHKyoXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728978289; c=relaxed/simple;
	bh=CcuqjoiRsiN3lo0AXnTABdKzc675y4vB9WXoPLYuEnM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=A/DH2/GKgwOv753/eFkrHIfXoFWqRit5ubgWIkqRvHiogRIoXp1pB39jHVrWIdpZiF8haz1g3bAjGwntIKwNo4VPglfEdCt5C/9dEjqbsU8tmtA2/BKLjYM2O+t2KETzupu8BvXhXFpaxUtMYwQSVwLOPr+B/8DB0E5k+aMHn9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dTYPdepI; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728978288; x=1760514288;
  h=from:to:cc:subject:date:message-id;
  bh=CcuqjoiRsiN3lo0AXnTABdKzc675y4vB9WXoPLYuEnM=;
  b=dTYPdepI34zwpGhtnUtYyN6v5Nbm5i8YX+h2XmSv7OEzh0wVe80nH7cO
   pL2ubbb6sGVCLohE0Kw+sbkzFBcgWcCG69UM3RX/bFe1S1P08sDjxm1bm
   sYH+I+fs+UAGdETfQsMYWSNDL5EpOgAjE+4tClWZBkZ79W2kUmhXPfsbO
   /qn3EuFgZCjKaKQopF2cjbnO2BITHLMwU2bP9aqneuLu9g3OQbW9lUfRV
   Hc3zK7+pxMlXLnmQ9sjn44M4f7secI+5BBPY2+GM5i3QmC4rZi6mRxJmF
   6JCDCfXWFTvSV/0Yvzy2XRKmCeFildNDby2jSmM+ZUnNnehpD1LvW4C3s
   g==;
X-CSE-ConnectionGUID: L962fNx3RlWiCP9uzWn/Og==
X-CSE-MsgGUID: ZROLThZXSiGXKG/4Ve9Dow==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="28483469"
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="28483469"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 00:44:44 -0700
X-CSE-ConnectionGUID: Rd3qZSIATiCSXS60ksQ3og==
X-CSE-MsgGUID: /+0sMCfSTd+ZvoeFhN992g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="77752214"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 00:44:42 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Diego Garcia Rodriguez <diego.garcia.rodriguez@intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] EDAC: Fix incorrect far-memory error source
Date: Tue, 15 Oct 2024 15:22:34 +0800
Message-Id: <20241015072236.24543-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

This series fixes an EDAC bug of the incorrect far-memory error
source on Granite Rapids.

Patch 1: Distinguish the memory error source details.
         This is a preparation for patch 2.

Patch 2: Fix the incorrect far-memory error source indicator.

This series is based on v6.12-rc3.

Qiuxu Zhuo (2):
  EDAC/skx_common: Distinguish the memory error source
  EDAC/{skx_common,i10nm}: Fix incorrect far-memory error source indicator

 drivers/edac/i10nm_base.c |  1 +
 drivers/edac/skx_common.c | 57 ++++++++++++++++++++++++++-------------
 drivers/edac/skx_common.h |  8 ++++++
 3 files changed, 48 insertions(+), 18 deletions(-)

base-commit: 8e929cb546ee42c9a61d24fae60605e9e3192354
-- 
2.17.1


