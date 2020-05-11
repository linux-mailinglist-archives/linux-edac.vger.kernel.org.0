Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7FB1CDA97
	for <lists+linux-edac@lfdr.de>; Mon, 11 May 2020 14:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgEKM74 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 11 May 2020 08:59:56 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:34185 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbgEKM74 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 11 May 2020 08:59:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1589201996; x=1620737996;
  h=to:cc:from:subject:message-id:date:mime-version:
   content-transfer-encoding;
  bh=rvUMtkAVfrgy8OOsei6dSyYOSNtnu+SYcmU5iH7/gzc=;
  b=AvjMh9ISb8OkPI/mJQLxCwhqZIutSNvPPi0DjTptTpKmDkqJ9f7QiwTB
   lg5R2oxKs+TEd71WnuSZKl1nE02GB5Bi0vEkV7E12wIfVVfhakxC9cs4Q
   XbfiegeVFJT7Agh+KBtnFxNGVY8gyKdBRYAE2W+6ZSba0QUFCKEpE60Jf
   4=;
IronPort-SDR: Osge9eBHgJQieXPzcNrCbA6kHGERSAcIQjeKIivB6MaB/YHI+TVR/nDkL7z00EarEI2RrYqHTM
 GqazAaYZcQ6Q==
X-IronPort-AV: E=Sophos;i="5.73,380,1583193600"; 
   d="scan'208";a="29564027"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-55156cd4.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 11 May 2020 12:59:43 +0000
Received: from EX13MTAUEE002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-55156cd4.us-west-2.amazon.com (Postfix) with ESMTPS id BE947A1FF4;
        Mon, 11 May 2020 12:59:41 +0000 (UTC)
Received: from EX13D08UEE001.ant.amazon.com (10.43.62.126) by
 EX13MTAUEE002.ant.amazon.com (10.43.62.24) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 11 May 2020 12:59:41 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D08UEE001.ant.amazon.com (10.43.62.126) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 11 May 2020 12:59:41 +0000
Received: from [192.168.12.223] (10.1.213.8) by mail-relay.amazon.com
 (10.43.62.224) with Microsoft SMTP Server (TLS) id 15.0.1497.2 via Frontend
 Transport; Mon, 11 May 2020 12:59:39 +0000
To:     "bp@alien8.de" <bp@alien8.de>,
        "james.morse@arm.com" <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "Krupnik, Ronen" <ronenk@amazon.com>, <talel@amazon.com>,
        <jonnyc@amazon.com>, "Hanoch, Uri" <hanochu@amazon.com>,
        <hhhawa@amazon.com>
From:   "Hawa, Hanna" <hhhawa@amazon.com>
Subject: [RFC] Support different block names with same EDAC device
Message-ID: <0ae313a4-97c3-5681-f22c-23decb261b74@amazon.com>
Date:   Mon, 11 May 2020 15:59:38 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi,

Amazon Alpine SoCs have different HW units that have an ability to 
report on correctable/uncorrectable errors. We want to add support for 
this HWs using dedicated EDAC driver based on edac device subsystem.
In edac_device_ctl_info() function one of the parameters is 
“edac_block_name”, to create nr_blocks kobjects based on that single 
block name.
Our target to create multiple block names with the same edac device, e.g.:
/sys/devices/system/edac/MY_HW_UNIT/error_name_a/
/sys/devices/system/edac/MY_HW_UNIT/error_name_b/
/sys/devices/system/edac/MY_HW_UNIT/error_name_c/
/sys/devices/system/edac/MY_HW_UNIT/error_name_a/

Can the edac device infrastructure support different block names? Shall 
we add support for such feature?

Thanks,
Hanna
