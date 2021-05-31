Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97012396270
	for <lists+linux-edac@lfdr.de>; Mon, 31 May 2021 16:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbhEaO45 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 31 May 2021 10:56:57 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:3308 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234288AbhEaOyx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 31 May 2021 10:54:53 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4FtypP6gwQz1BGky;
        Mon, 31 May 2021 22:48:29 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 22:53:10 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 22:53:09 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Johannes Thumshirn <morbidrsa@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Jan Luebbe <jlu@pengutronix.de>,
        Andre Przywara <andre.przywara@arm.com>,
        Channagoud Kadabi <ckadabi@codeaurora.org>,
        "Venkata Narendra Kumar Gutta" <vnkgutta@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Khuong Dinh" <khuong@os.amperecomputing.com>,
        York Sun <york.sun@nxp.com>,
        linux-edac <linux-edac@vger.kernel.org>,
        linux-mips <linux-mips@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 0/3] edac: Fix error return code when edac_pci_add_device() or edac_device_add_device() fails 
Date:   Mon, 31 May 2021 22:52:59 +0800
Message-ID: <20210531145302.9655-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

v1 --> v2:
1. When edac_pci_add_device() fails, fix to return -ENODEV
2. When edac_device_add_device() fails, fix to return -ENXIO
3. Use 'ret' instead of 'res' to store the return value

Zhen Lei (3):
  edac: Fix error return code when edac_pci_add_device() fails
  edac: Fix error return code when edac_device_add_device() fails
  edac: Use 'ret' instead of 'res' to store the return value

 drivers/edac/altera_edac.c      | 70 +++++++++++++++++----------------
 drivers/edac/amd8111_edac.c     |  2 +
 drivers/edac/armada_xp_edac.c   |  8 ++--
 drivers/edac/cpc925_edac.c      | 16 ++++----
 drivers/edac/fsl_ddr_edac.c     | 24 +++++------
 drivers/edac/highbank_l2_edac.c | 22 ++++++-----
 drivers/edac/highbank_mc_edac.c | 20 +++++-----
 drivers/edac/layerscape_edac.c  |  8 ++--
 drivers/edac/mpc85xx_edac.c     | 46 +++++++++++-----------
 drivers/edac/octeon_edac-pci.c  |  9 +----
 drivers/edac/qcom_edac.c        |  4 +-
 drivers/edac/skx_base.c         |  6 +--
 drivers/edac/thunderx_edac.c    | 28 +++++++------
 drivers/edac/xgene_edac.c       |  6 +--
 14 files changed, 138 insertions(+), 131 deletions(-)

-- 
2.26.0.106.g9fadedd


