Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7019F264500
	for <lists+linux-edac@lfdr.de>; Thu, 10 Sep 2020 13:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbgIJLC7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Sep 2020 07:02:59 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35348 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730504AbgIJLAq (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 10 Sep 2020 07:00:46 -0400
Received: from zn.tnic (p200300ec2f133200fd9e4f04ab274470.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:3200:fd9e:4f04:ab27:4470])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E413B1EC04D1;
        Thu, 10 Sep 2020 13:00:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1599735618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=YgXBtSBP0UMGKfZ5Kks76k9ZUNVxHXLDGwg7ZTPYxUc=;
        b=d15TB85SEN/OgnKd9nb5gmxu9tqYB8oZMF4loy/tXTr4eG/8UJOFl15dsWbolViYlfniQk
        7P+DkV3WMSS+Ujf22HZkKbxmCTPjXmpmVN1mNAyc08khx1p4UTgX3NxfrZururT5wqEVEe
        m27QL2Cr7lGhdQwcWvPYq6v9laJbeyo=
Date:   Thu, 10 Sep 2020 13:00:12 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     mchehab@kernel.org, tony.luck@intel.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/mc_sysfs: add missing newlines when printing
 'max(dimm)_location'
Message-ID: <20200910110012.GD8357@zn.tnic>
References: <1599207563-41819-1-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1599207563-41819-1-git-send-email-wangxiongfeng2@huawei.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Sep 04, 2020 at 04:19:23PM +0800, Xiongfeng Wang wrote:
> When I cat 'max_location' and 'dimm_location' by sysfs, it displays as
> follows. It's better to add a newline for easy reading.
> 
> [root@localhost /]# cat /sys/devices/system/edac/mc/mc0/max_location
> memory 3 [root@localhost /]# cat /sys/devices/system/edac/mc/mc0/dimm0/dimm_location
> memory 0 [root@localhost /]#

Please use this commit message for your next version:

EDAC/mc_sysfs: Add missing newlines when printing {max,dimm}_location

Reading those sysfs entries gives:

  [root@localhost /]# cat /sys/devices/system/edac/mc/mc0/max_location
  memory 3 [root@localhost /]# cat /sys/devices/system/edac/mc/mc0/dimm0/dimm_location
  memory 0 [root@localhost /]#

Add newlines after the value it prints for better readability.

> @@ -821,6 +825,7 @@ static ssize_t mci_max_location_show(struct device *dev,
>  			     edac_layer_name[mci->layers[i].type],
>  			     mci->layers[i].size - 1);
>  	}
> +	p += sprintf(p, "\n");

No size checking here?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
