Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3D2BBC25
	for <lists+linux-edac@lfdr.de>; Mon, 23 Sep 2019 21:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfIWTSR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 23 Sep 2019 15:18:17 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:26701 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfIWTSR (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 23 Sep 2019 15:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1569266296; x=1600802296;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=bsmJrqHV0ewka5Gks3Mfd3lHn1T9YXvQXU5YVqVSqwk=;
  b=p6zgLyP4dVaU6HhYNpk2k0wmfejOYuJ5kg94dVXM4mrF+hhQoEVw9h2y
   FB3FPlKmjcw1Hjbu5GK/zULfJ47jiWdqrd4X/ik0tHaw5NiBCnp2UHDOS
   zaxwJWVch1VtH4DiH4VCCZdOT04fSWWWX6wmOUD0mgeMTf7oJXukmKTxT
   Q=;
X-IronPort-AV: E=Sophos;i="5.64,541,1559520000"; 
   d="scan'208";a="786844310"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 23 Sep 2019 19:18:03 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com (Postfix) with ESMTPS id 0FBE2A2412;
        Mon, 23 Sep 2019 19:18:03 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 23 Sep 2019 19:18:02 +0000
Received: from ua9e4f3715fbc5f.ant.amazon.com (10.43.161.176) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 23 Sep 2019 19:17:55 +0000
From:   Hanna Hawa <hhhawa@amazon.com>
To:     <bp@alien8.de>, <mchehab@kernel.org>, <james.morse@arm.com>,
        <rrichter@marvell.com>
CC:     <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dwmw@amazon.co.uk>, <benh@amazon.com>, <ronenk@amazon.com>,
        <talel@amazon.com>, <jonnyc@amazon.com>, <hanochu@amazon.com>,
        <hhhawa@amazon.com>
Subject: [PATCH v4 0/2] Add an API for edac device, for mulriple errors
Date:   Mon, 23 Sep 2019 20:17:39 +0100
Message-ID: <20190923191741.29322-1-hhhawa@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.176]
X-ClientProxiedBy: EX13D08UWC002.ant.amazon.com (10.43.162.168) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add an API for EDAC device to report for multiple errors, and move the
old report function to use the new API.

Changes from v3:
----------------
- Move count check to inline function
- Fix count variable describtion
  (Reported-by: kbuild test robot <lkp@intel.com>)

Changes from v2:
----------------
- Remove copy of edac_device_handle_*() functions, modify the existing
functions.

Changes from v1:
----------------
- use 'unsigned int' instead of u16
- update variable name to be count
- remove WARN_ON and simply exit if count is zero
- add inline functions in header file

Hanna Hawa (2):
  edac: Add an API for edac device to report for multiple errors
  edac: move edac_device_handle_*() API functions to header

 drivers/edac/edac_device.c | 44 +++++++++++++++++----------------
 drivers/edac/edac_device.h | 50 +++++++++++++++++++++++++++++++++-----
 2 files changed, 67 insertions(+), 27 deletions(-)

-- 
2.17.1

