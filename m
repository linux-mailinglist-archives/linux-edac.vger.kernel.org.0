Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DE261E379
	for <lists+linux-edac@lfdr.de>; Sun,  6 Nov 2022 17:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiKFQgl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Sun, 6 Nov 2022 11:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiKFQgk (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 6 Nov 2022 11:36:40 -0500
X-Greylist: delayed 630 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Nov 2022 08:36:39 PST
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B5FAE49
        for <linux-edac@vger.kernel.org>; Sun,  6 Nov 2022 08:36:39 -0800 (PST)
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay01.hostedemail.com (Postfix) with ESMTP id D682B1C652A;
        Sun,  6 Nov 2022 16:26:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id 6487D17;
        Sun,  6 Nov 2022 16:25:20 +0000 (UTC)
Message-ID: <72d228fc27951a7ba9e607d9fc433b3c64a801e3.camel@perches.com>
Subject: Re: [PATCH] EDAC: altera: Remove unnecessary print function
 dev_err()
From:   Joe Perches <joe@perches.com>
To:     wangkailong@jari.cn, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, rric@kernel.org
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 06 Nov 2022 08:26:04 -0800
In-Reply-To: <cf4581a.ba.1844d24fef3.Coremail.wangkailong@jari.cn>
References: <cf4581a.ba.1844d24fef3.Coremail.wangkailong@jari.cn>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 6487D17
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: nwagrj9zn7r167ofd8wyn3ziaqqiegqf
X-Rspamd-Server: rspamout08
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19NVUyMV9EgdLGR/NZuAAOGhLlXbrm2DI0=
X-HE-Tag: 1667751920-668540
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, 2022-11-06 at 21:33 +0800, wangkailong@jari.cn wrote:
> Eliminate the follow coccicheck warning:
> 
> ./drivers/edac/altera_edac.c:2153:2-9: line 2153 is redundant because
> platform_get_irq() already prints an error
> ./drivers/edac/altera_edac.c:2188:2-9: line 2188 is redundant because
> platform_get_irq() already prints an error
[]
> diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
[]
> @@ -2150,7 +2150,6 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
>  
>  	edac->sb_irq = platform_get_irq(pdev, 0);
>  	if (edac->sb_irq < 0) {
> -		dev_err(&pdev->dev, "No SBERR IRQ resource\n");
>  		return edac->sb_irq;
>  	}

Should delete now unnecessary braces too

>  
> @@ -2185,7 +2184,6 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
>  #else
>  	edac->db_irq = platform_get_irq(pdev, 1);
>  	if (edac->db_irq < 0) {
> -		dev_err(&pdev->dev, "No DBERR IRQ resource\n");
>  		return edac->db_irq;
>  	}
>  	irq_set_chained_handler_and_data(edac->db_irq,

