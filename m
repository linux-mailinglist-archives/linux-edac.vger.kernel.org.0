Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5E242FA15
	for <lists+linux-edac@lfdr.de>; Thu, 30 May 2019 12:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbfE3KP5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 30 May 2019 06:15:57 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:55802 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728040AbfE3KP5 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 30 May 2019 06:15:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1559211356; x=1590747356;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=qT4DhB6YwyuERZdQm5AhjSmMMee3IQql00hvhas3eNY=;
  b=q+SzuZprDqJ2CKKN622gSZEXah8kbLltpfL2dl8nEFPH63AwOKjrSuvd
   cvgP9o/N+LYNGs70fGcqCoNggVh2125cKz9/UUcHmhocjG3SxnXrkiH/5
   4ZmBLOS5woMpRwth1QYzt82xKVi9WobN3/js2lMyLq9l6CnW8a5aQw7fb
   c=;
X-IronPort-AV: E=Sophos;i="5.60,530,1549929600"; 
   d="scan'208";a="768245347"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 30 May 2019 10:15:55 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com (Postfix) with ESMTPS id 954C3C09B4;
        Thu, 30 May 2019 10:15:51 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 30 May 2019 10:15:50 +0000
Received: from ub6d44c9ce3e25c.ant.amazon.com (10.43.160.237) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 30 May 2019 10:15:42 +0000
From:   Hanna Hawa <hhhawa@amazon.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <bp@alien8.de>,
        <mchehab@kernel.org>, <james.morse@arm.com>, <davem@davemloft.net>,
        <gregkh@linuxfoundation.org>, <nicolas.ferre@microchip.com>,
        <paulmck@linux.ibm.com>, <dwmw@amazon.co.uk>, <benh@amazon.com>
CC:     <ronenk@amazon.com>, <talel@amazon.com>, <jonnyc@amazon.com>,
        <hanochu@amazon.com>, <hhhawa@amazon.com>,
        <linux-edac@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] Add support for Amazon's Annapurna Labs EDAC for L1/L2
Date:   Thu, 30 May 2019 13:15:27 +0300
Message-ID: <1559211329-13098-1-git-send-email-hhhawa@amazon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.237]
X-ClientProxiedBy: EX13D23UWC001.ant.amazon.com (10.43.162.196) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add support for error detection and correction for Amazon's Annapurna Labs SoCs
for L1/L2 caches.
Alpine SoCs support L1 and L2 error correction check based on ARM implementation.

Hanna Hawa (2):
  dt-bindings: EDAC: add Amazon Annapurna Labs EDAC binding
  edac: add support for Amazon's Annapurna Labs EDAC

 .../devicetree/bindings/edac/amazon-al-edac.txt    |  16 ++
 MAINTAINERS                                        |   7 +
 drivers/edac/Kconfig                               |   9 +
 drivers/edac/Makefile                              |   1 +
 drivers/edac/amazon_al_ca57_edac.c                 | 283 +++++++++++++++++++++
 5 files changed, 316 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/amazon-al-edac.txt
 create mode 100644 drivers/edac/amazon_al_ca57_edac.c

-- 
2.7.4

