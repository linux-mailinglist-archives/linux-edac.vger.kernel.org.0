Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0FA548D565
	for <lists+linux-edac@lfdr.de>; Thu, 13 Jan 2022 11:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiAMKGl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 13 Jan 2022 05:06:41 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:55137 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiAMKGi (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 13 Jan 2022 05:06:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1642068399; x=1673604399;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gRObVb2efQEchpFIfpjUYhaUuaApiy9HH1WsKyStpPI=;
  b=PMak1J/7JaRcjSIaXbxFY2g59KgUGG51F1kmFGuEpUvi7N68eUl4sWrS
   7sxkEIpPk/HuRGOD99M3bQa7rWQwFJDVTFmLO+kRHlCFCm53El0vpJ+8X
   2LFrJfJY2ipB4Ilz6VVTSzees1PVlPBjyqdDKdIraYXMI74PmQ6Hcsuam
   Q=;
X-IronPort-AV: E=Sophos;i="5.88,284,1635206400"; 
   d="scan'208";a="169823163"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-0085f2c8.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP; 13 Jan 2022 10:06:25 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2b-0085f2c8.us-west-2.amazon.com (Postfix) with ESMTPS id F072E4129A;
        Thu, 13 Jan 2022 10:06:23 +0000 (UTC)
Received: from EX13D13UWB001.ant.amazon.com (10.43.161.156) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Thu, 13 Jan 2022 10:06:23 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D13UWB001.ant.amazon.com (10.43.161.156) with Microsoft SMTP Server (TLS)
 id 15.0.1497.26; Thu, 13 Jan 2022 10:06:23 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP
 Server id 15.0.1497.28 via Frontend Transport; Thu, 13 Jan 2022 10:06:23
 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id 8E2272D48; Thu, 13 Jan 2022 10:06:22 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <bp@alien8.de>
CC:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ronenk@amazon.com>,
        <talel@amazon.com>, <hhhawa@amazon.com>, <jonnyc@amazon.com>,
        <hanochu@amazon.com>, <farbere@amazon.com>
Subject: [PATCH 0/4] edac_align_ptr() bug fix and refactoring
Date:   Thu, 13 Jan 2022 10:06:18 +0000
Message-ID: <20220113100622.12783-1-farbere@amazon.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Fix address alignment and return value casting, modify data types
and refactor the flow to be more clear and readable.

Eliav Farber (4):
  EDAC: Fix calculation of returned address and next offset in
    edac_align_ptr()
  EDAC: Remove unnecessary cast to char* in edac_align_ptr() function
  EDAC: Refactor edac_align_ptr() to use u8/u16/u32/u64 data types
  EDAC: Refactor edac_align_ptr() flow

 drivers/edac/edac_mc.c | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

-- 
2.32.0

