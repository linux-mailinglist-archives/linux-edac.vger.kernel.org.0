Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F40072A9776
	for <lists+linux-edac@lfdr.de>; Fri,  6 Nov 2020 15:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbgKFOMv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 6 Nov 2020 09:12:51 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6753 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbgKFOMt (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 6 Nov 2020 09:12:49 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CSMlt3HbSzkfn5;
        Fri,  6 Nov 2020 22:12:26 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.230) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Fri, 6 Nov 2020 22:12:26 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86 <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        linux-edac <linux-edac@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 0/1] x86/mce: correct the detection of invalid mce priorities
Date:   Fri, 6 Nov 2020 22:12:15 +0800
Message-ID: <20201106141216.2062-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.230]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

v1 --> v2:
Update the detection of invalid mce priorities, the WARN_ON() is needed.

v1:
Remove the WARN_ON() in mce_register_decode_chain().

Zhen Lei (1):
  x86/mce: correct the detection of invalid mce priorities

 arch/x86/include/asm/mce.h     | 3 ++-
 arch/x86/kernel/cpu/mce/core.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.26.0.106.g9fadedd


