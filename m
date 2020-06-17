Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C7A1FC4C6
	for <lists+linux-edac@lfdr.de>; Wed, 17 Jun 2020 05:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgFQDkd (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 16 Jun 2020 23:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgFQDkc (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 16 Jun 2020 23:40:32 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A0BC061573;
        Tue, 16 Jun 2020 20:40:31 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id m7so306997plt.5;
        Tue, 16 Jun 2020 20:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bc0WXoZrOchMdti95LNxJS1iuh37xyfaq6BHQ8s27lc=;
        b=itbtfbO5VjL1l/KwHSwnQRyNlWsgcTtCDSUKVOpUjrrt+qdN3Bz0Mdl1Br8zvORH4O
         Ea/bz2K2Pb2yaxSFgMNXs5crvh1OdxVO7/FI0BsuapJBPHNAqq45SByYcqNgfT27jV83
         NHvdRNyhvRpOlYj15gNn+nwsTilQiKpMvApYeowb7/1yNQOdIFdHtLpMJRzuuVgSvZnC
         mIOlTtPGSbuwnkjcvtdZPDrzjJBSBCgyq+5uCSM1uyYpP6eYbDnYpwu/czRdfyQcVxPZ
         dAZpICRUSaV+3GexzYtEvAEKGF9uE2UaI3dlqSZQYOacMTxO0MURJcJy3Wy6k5MGgRPa
         aJkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=bc0WXoZrOchMdti95LNxJS1iuh37xyfaq6BHQ8s27lc=;
        b=refDNNCIBk5dVJtMZ/1xkc9rqAVNzgi/YdlFRoESSmuDOv9WKj8j3HSqzMhPlxl70M
         pJavlbKgsmuvLQWqJWevZo2OzxijppajLCoXTczdvRUCNjiS+Vl3egjMVhe7ddZmMC6O
         JQThQV4Y42wnWzCd2w/QKW7bRtIXgu5xWTMxJqwE1xzZSYbNh8ic9LxdLrBYW29j9IeS
         LLN2+1rInVp1VTTrARhoDCCPGB2hPgLzdxMSWKMyMUvIhN5jZWPr10W8I7Fi1iguCk/q
         KILID9kjZDEHJ7468u0/rdbPi/yaIdzA3Y3Bz/qcHaxextuWmGGlxF2v543MsrGi8hMQ
         aU6Q==
X-Gm-Message-State: AOAM531AaCZ14GPZjU7GYzXAKzayViBc+JXXVVJ2dim9M6eoXMKBz7gQ
        b2XWqNzkFreBy0d7yLWN4sA=
X-Google-Smtp-Source: ABdhPJzGWqrdxcl0TXDWvUGHWt27TQFaJAUXEemslZUu7Xnilyn95lCOGqBIY3fKRngeLlmwKPHkxg==
X-Received: by 2002:a17:90a:d784:: with SMTP id z4mr6023649pju.30.1592365230574;
        Tue, 16 Jun 2020 20:40:30 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u61sm3994790pjb.7.2020.06.16.20.40.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Jun 2020 20:40:29 -0700 (PDT)
Date:   Tue, 16 Jun 2020 20:40:28 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jacky Hu <hengqing.hu@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        yazen.ghannam@amd.com, bp@alien8.de, clemens@ladisch.de
Subject: Re: [PATCH] hwmon: (k10temp) Add AMD family 17h model 60h probe
Message-ID: <20200617034028.GA1614@roeck-us.net>
References: <20200616180940.GN13515@zn.tnic>
 <20200617013255.391975-1-hengqing.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200617013255.391975-1-hengqing.hu@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jun 17, 2020 at 09:32:55AM +0800, Jacky Hu wrote:
> With this patch applied, output from 4800H (idle) looks as follows:
> 
> k10temp-pci-00c3
> Adapter: PCI adapter
> Vcore:         1.55 V
> Vsoc:          1.55 V
> Tctl:         +49.6°C
> Tdie:         +49.6°C
> Icore:         0.00 A
> Isoc:          0.00 A
> 
> Signed-off-by: Jacky Hu <hengqing.hu@gmail.com>
> ---
>  drivers/hwmon/k10temp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index 8f12995ec133..287e9cf2aab9 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -583,6 +583,7 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  			k10temp_get_ccd_support(pdev, data, 4);
>  			break;
>  		case 0x31:	/* Zen2 Threadripper */
> +		case 0x60:	/* Zen2 APU */

Unfortunately it is not that simple. Output above and the little data I have
available suggests that current and voltage measurements are different on the
APU. That means that show_current must remain false.
This will require a separate case statement which doesn't set any flags.

Guenter

>  		case 0x71:	/* Zen2 */
>  			data->show_current = !is_threadripper() && !is_epyc();
>  			data->cfactor[0] = CFACTOR_ICORE;
> -- 
> 2.27.0
> 
