Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFAF7415A4E
	for <lists+linux-edac@lfdr.de>; Thu, 23 Sep 2021 10:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240005AbhIWIwI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 Sep 2021 04:52:08 -0400
Received: from smtp-fw-80006.amazon.com ([99.78.197.217]:64424 "EHLO
        smtp-fw-80006.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240003AbhIWIwI (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 23 Sep 2021 04:52:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1632387038; x=1663923038;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RDnsOMYZPGwO01nMsZWljiZMXc8S7JiVdEmdwyo2rNc=;
  b=X06j1gdptSWHPX+cMRuvQHkcvB+auTha/545JOoosN/w/Gm8Nr7Wu1TD
   3ZYx/WUQiYVCLyxKX+Ob9gCIiJgGCpQY01FciKP0EdovdPai/cx6dKthW
   DXrWjsnDt1GE/pWt32IxXBAMd1pq1Xxnqs43pudyLnYcA/RMi0Bwdj3dq
   o=;
X-IronPort-AV: E=Sophos;i="5.85,316,1624320000"; 
   d="scan'208";a="29030185"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-1box-2b-eee1d651.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP; 23 Sep 2021 08:50:30 +0000
Received: from EX13D01EUB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-1box-2b-eee1d651.us-west-2.amazon.com (Postfix) with ESMTPS id 53A7583BDF;
        Thu, 23 Sep 2021 08:50:27 +0000 (UTC)
Received: from [192.168.21.60] (10.43.160.106) by EX13D01EUB001.ant.amazon.com
 (10.43.166.194) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Thu, 23 Sep
 2021 08:50:21 +0000
Message-ID: <cb981992-a44f-d2d2-9c6d-31c5d53c74c1@amazon.com>
Date:   Thu, 23 Sep 2021 11:50:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH] EDAC/al-mc-edac: Make use of the helper function
 devm_add_action_or_reset()
Content-Language: en-US
To:     Cai Huoqing <caihuoqing@baidu.com>
CC:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Ronen Krupnik <ronenk@amazon.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <talelshenhar@gmail.com>
References: <20210922125924.321-1-caihuoqing@baidu.com>
From:   "Shenhar, Talel" <talel@amazon.com>
In-Reply-To: <20210922125924.321-1-caihuoqing@baidu.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.106]
X-ClientProxiedBy: EX13D48UWA004.ant.amazon.com (10.43.163.61) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org


> The helper function devm_add_action_or_reset() will internally
> call devm_add_action(), and if devm_add_action() fails then it will
> execute the action mentioned and return the error code. So
> use devm_add_action_or_reset() instead of devm_add_action()
> to simplify the error handling, reduce the code.
>
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
Acked-by: Talel Shenhar <talel@amazon.com>
> ---
>   drivers/edac/al_mc_edac.c | 12 ++++--------
>   1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/edac/al_mc_edac.c b/drivers/edac/al_mc_edac.c
> index 7d4f396c27b5..178b9e581a72 100644
> --- a/drivers/edac/al_mc_edac.c
> +++ b/drivers/edac/al_mc_edac.c
> @@ -238,11 +238,9 @@ static int al_mc_edac_probe(struct platform_device *pdev)
>          if (!mci)
>                  return -ENOMEM;
>
> -       ret = devm_add_action(&pdev->dev, devm_al_mc_edac_free, mci);
> -       if (ret) {
> -               edac_mc_free(mci);
> +       ret = devm_add_action_or_reset(&pdev->dev, devm_al_mc_edac_free, mci);
> +       if (ret)
>                  return ret;
> -       }
>
>          platform_set_drvdata(pdev, mci);
>          al_mc = mci->pvt_info;
> @@ -293,11 +291,9 @@ static int al_mc_edac_probe(struct platform_device *pdev)
>                  return ret;
>          }
>
> -       ret = devm_add_action(&pdev->dev, devm_al_mc_edac_del, &pdev->dev);
> -       if (ret) {
> -               edac_mc_del_mc(&pdev->dev);
> +       ret = devm_add_action_or_reset(&pdev->dev, devm_al_mc_edac_del, &pdev->dev);
> +       if (ret)
>                  return ret;
> -       }
>
>          if (al_mc->irq_ue > 0) {
>                  ret = devm_request_irq(&pdev->dev,
> --
> 2.25.1
>
