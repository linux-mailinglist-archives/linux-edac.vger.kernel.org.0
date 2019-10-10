Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2BCD2F9E
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2019 19:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfJJRbR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Oct 2019 13:31:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35976 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfJJRbQ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 10 Oct 2019 13:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sVb8M7BboexT7ZsVMXF4zi15mQu4gxQl1u3eh+HmGzo=; b=dF8ctdYtqBOrVgH2E6M8C5m3X
        FFFi9zwfcUw+1G7auRy+WLm0LHzlSeXGYoChBbTgXq/bbWW7UKo1ptE3SAG1Cc/K5uNzAYq1E/LZE
        69pTgOZiUovZOP6NqF7mykxwuPZ4eLFoq451o45qbyWKcFws93ARb9A6FS2oNY6liyblInq7ZZ5vY
        EDujutvVRappxehD51gnqb/J8/NXqpG9Tp4msm7rZJnMIKDhUSs6qu1tT4fcc1nEZtBzb2HJuDU1o
        yrvnsTSfo5INYkHAvTWi1qgMwpTDJaQ6Phki4Wom9e360cEIN2DmT+WgI79GBac3WgWTiU1743bNV
        XgbVJuMTg==;
Received: from 177.205.100.4.dynamic.adsl.gvt.net.br ([177.205.100.4] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIcHT-0006Fr-08; Thu, 10 Oct 2019 17:31:15 +0000
Date:   Thu, 10 Oct 2019 14:31:11 -0300
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Xiaofei Tan <tanxiaofei@huawei.com>
Cc:     <linux-edac@vger.kernel.org>, <linuxarm@huawei.com>,
        <shiju.jose@huawei.com>
Subject: Re: [PATCH 1/1] rasdaemon: fix the issue of sqlite3 integer bind
 parameter mismatch
Message-ID: <20191010143111.3a4911fc@coco.lan>
In-Reply-To: <1565230470-52916-1-git-send-email-tanxiaofei@huawei.com>
References: <1565230470-52916-1-git-send-email-tanxiaofei@huawei.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Em Thu, 8 Aug 2019 10:14:30 +0800
Xiaofei Tan <tanxiaofei@huawei.com> escreveu:

> Some interger fields of arm_event and mc_event are 8 bytes width,
> and sqlite3_bind_int64() should be used when restore the event to
> sqlite3. But we use sqlite3_bind_int() in current code. This will
> lead to an wrong value in sqlite3 DB.
> 
> This patch is to fix the issue.
> 
> Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>

Applied, thanks!

> ---
>  ras-record.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/ras-record.c b/ras-record.c
> index 4c8b55b..0bf0080 100644
> --- a/ras-record.c
> +++ b/ras-record.c
> @@ -94,9 +94,9 @@ int ras_store_mc_event(struct ras_events *ras, struct ras_mc_event *ev)
>  	sqlite3_bind_int (priv->stmt_mc_event,  7, ev->top_layer);
>  	sqlite3_bind_int (priv->stmt_mc_event,  8, ev->middle_layer);
>  	sqlite3_bind_int (priv->stmt_mc_event,  9, ev->lower_layer);
> -	sqlite3_bind_int (priv->stmt_mc_event, 10, ev->address);
> -	sqlite3_bind_int (priv->stmt_mc_event, 11, ev->grain);
> -	sqlite3_bind_int (priv->stmt_mc_event, 12, ev->syndrome);
> +	sqlite3_bind_int64 (priv->stmt_mc_event, 10, ev->address);
> +	sqlite3_bind_int64 (priv->stmt_mc_event, 11, ev->grain);
> +	sqlite3_bind_int64 (priv->stmt_mc_event, 12, ev->syndrome);
>  	sqlite3_bind_text(priv->stmt_mc_event, 13, ev->driver_detail, -1, NULL);
>  	rc = sqlite3_step(priv->stmt_mc_event);
>  	if (rc != SQLITE_OK && rc != SQLITE_DONE)
> @@ -242,7 +242,7 @@ int ras_store_arm_record(struct ras_events *ras, struct ras_arm_event *ev)
>  	sqlite3_bind_text (priv->stmt_arm_record,  1,  ev->timestamp, -1, NULL);
>  	sqlite3_bind_int  (priv->stmt_arm_record,  2,  ev->error_count);
>  	sqlite3_bind_int  (priv->stmt_arm_record,  3,  ev->affinity);
> -	sqlite3_bind_int  (priv->stmt_arm_record,  4,  ev->mpidr);
> +	sqlite3_bind_int64  (priv->stmt_arm_record,  4,  ev->mpidr);
>  	sqlite3_bind_int  (priv->stmt_arm_record,  5,  ev->running_state);
>  	sqlite3_bind_int  (priv->stmt_arm_record,  6,  ev->psci_state);
>  



Thanks,
Mauro
