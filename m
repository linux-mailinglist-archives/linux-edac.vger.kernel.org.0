Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180AD1FBCD9
	for <lists+linux-edac@lfdr.de>; Tue, 16 Jun 2020 19:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730227AbgFPR1t (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 16 Jun 2020 13:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729241AbgFPR1t (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 16 Jun 2020 13:27:49 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8023C061573;
        Tue, 16 Jun 2020 10:27:48 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0f4c001d7e5f403e90d72b.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:4c00:1d7e:5f40:3e90:d72b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 316D91EC037C;
        Tue, 16 Jun 2020 19:27:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592328467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=fn1OMVWpuGa0Oq+WM7TDN2GXu4ci7AEYPf0Y0l7PVh8=;
        b=oe0BOykRC1eYspS/7nwb1X6osXmo0K+lrynjqAV1xKLwu4hoCi/IpEy+XBl2YmSXIZhBtm
        AQOQ5LsXt6c2T3FKv4pbU8SzZ8QbvB9PDk3gpAAmHas1EqsSqowi3/VHjSNQ3RDPTDc+J+
        kFwEG4ZjsNb+wwnr2gnGeHqyANc/6x0=
From:   Borislav Petkov <bp@alien8.de>
To:     Mauro Carvalho Chehab <mchehab@infradead.org>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] EDAC/ghes: Some cleanups
Date:   Tue, 16 Jun 2020 19:27:33 +0200
Message-Id: <20200616172737.30171-1-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Hi,

here are some cleanups which came up recently.

Thx.

Borislav Petkov (2):
  EDAC/ghes: Scan the system once on driver init
  EDAC: Remove edac_get_dimm_by_index()

Robert Richter (2):
  EDAC/ghes: Setup DIMM label from DMI and use it in error reports
  EDAC/ghes: Remove unused members of struct ghes_edac_pvt, rename it to
    ghes_pvt

 drivers/edac/ghes_edac.c | 323 +++++++++++++++++++++++----------------
 include/linux/edac.h     |  29 +---
 2 files changed, 200 insertions(+), 152 deletions(-)

-- 
2.21.0

