Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E721487D9D
	for <lists+linux-edac@lfdr.de>; Fri,  7 Jan 2022 21:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiAGUWY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 7 Jan 2022 15:22:24 -0500
Received: from mga04.intel.com ([192.55.52.120]:46796 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230012AbiAGUWY (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 7 Jan 2022 15:22:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641586943; x=1673122943;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OKZl4ThMotCxOA/nRrfu4xtwbWLIdLeaDwe+BMDXgr0=;
  b=mvOxQm29sAycisBfx660sbARDKYuYzH0+QUjLCRGGDHkzuEdx+zel+rk
   ZTHmkoEUzI+VBHUfX793s43JRvpcqpSWfIOuQX+fhJZPWHXKFjwCUKDM3
   JC68fdNGRRF8ebs4ghyBMvuFmD+ccpN1v43ceu7H8oxql5KVK2Upk2clu
   aqoCiYivWZ2VzcfgaQD4yrWwUzonEwtkGKNj9z8FKCuboRNWgaK2+7QUO
   csSf9WCQ6QCBlcUzlQkv87KWZmFi3BpP9jJdwfPunaywKVk8JTa+YXwef
   cbVHTt+VUCCFTtu0TiQL10ac9agtE/GZWmOG67PowZ/CpLr/g95AfsmEK
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="241751510"
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="241751510"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 12:21:22 -0800
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="513925177"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 12:21:21 -0800
Date:   Fri, 7 Jan 2022 12:21:20 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Borislav Petkov <bp@alien8.de>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] One late urgent EDAC driver fix from the RAS tree
Message-ID: <YdigwC6Od5wQCyFF@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The following changes since commit c9e6606c7fe92b50a02ce51dda82586ebdf99b48:

  Linux 5.16-rc8 (2022-01-02 14:23:25 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v5.16

for you to fetch changes up to c370baa328022cbd46c59c821d1b467a97f047be:

  EDAC/i10nm: Release mdev/mbase when failing to detect HBM (2022-01-04 09:08:00 -0800)

----------------------------------------------------------------
Fix 10nm EDAC driver to release and unmap resources on systems without HBM

----------------------------------------------------------------
Qiuxu Zhuo (1):
      EDAC/i10nm: Release mdev/mbase when failing to detect HBM

 drivers/edac/i10nm_base.c | 9 +++++++++
 1 file changed, 9 insertions(+)
