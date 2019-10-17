Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22536DAF37
	for <lists+linux-edac@lfdr.de>; Thu, 17 Oct 2019 16:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439825AbfJQOJR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 17 Oct 2019 10:09:17 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46602 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbfJQOJR (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 17 Oct 2019 10:09:17 -0400
Received: by mail-ot1-f65.google.com with SMTP id 89so1957179oth.13;
        Thu, 17 Oct 2019 07:09:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kXGnqFYJa8gxk84zjaw258zWcPW1sB63qQ3t9jdm74M=;
        b=LJK1wmj31xyIwxT0iBvFmuJiBcM46Sy8zCtl3RhUDD6q79Ji9kTbmUJJKiBGoNbGyT
         5Xj+jzsMktKO/SBhSyxF24i9On/xDvRGl0mVJDi01iqKZEMxr4k01H0It3dJjwP/LKHv
         Db9SKymLeiOvFXGr91c3gkw9e1ig+gKIIp8xGU6dA8golIsWoptAGR/VBTj2da3hAc1W
         oIa1khIfZ1GPDXKp7TSKM+H3inNgz/gLpkRlcIuNnBIpQXeQNaFXSVODvQfrkcO8PZeM
         eAOLDf7aG+Bvv7fjMmM1Pe2rRCrihxVWa6p3/QLunGsH3H0DVhCLvamQDDxMauRMZh5k
         L8gA==
X-Gm-Message-State: APjAAAWvnwUTcSGVHdjhmmRR76+M18uUyEbWZpxrjNFDYVofjny7D2O4
        4b+qGEKNO7w+r1Dh6ONXGw==
X-Google-Smtp-Source: APXvYqzLM9ovRh2qGOqpLD8UeBmHywdySl5GPPNx0DqB4KZyst3Sp7rp33P5TB0666e1K2JiAr8IvA==
X-Received: by 2002:a05:6830:1f09:: with SMTP id u9mr3421418otg.310.1571321356236;
        Thu, 17 Oct 2019 07:09:16 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 60sm644410oto.27.2019.10.17.07.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 07:09:15 -0700 (PDT)
Date:   Thu, 17 Oct 2019 09:09:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hanna Hawa <hhhawa@amazon.com>
Cc:     bp@alien8.de, mchehab@kernel.org, mark.rutland@arm.com,
        james.morse@arm.com, robh+dt@kernel.org, frowand.list@gmail.com,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        linus.walleij@linaro.org, daniel@iogearbox.net,
        paulmck@linux.ibm.com, Sudeep.Holla@arm.com,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        devicetree@vger.kernel.org, dwmw@amazon.co.uk, benh@amazon.com,
        ronenk@amazon.com, talel@amazon.com, jonnyc@amazon.com,
        hanochu@amazon.com, hhhawa@amazon.com
Subject: Re: [PATCH v7 2/3] of: EXPORT_SYMBOL_GPL of_find_next_cache_node
Message-ID: <20191017140914.GA21404@bogus>
References: <20191015120927.10470-1-hhhawa@amazon.com>
 <20191015120927.10470-3-hhhawa@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015120927.10470-3-hhhawa@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, 15 Oct 2019 13:09:26 +0100, Hanna Hawa wrote:
> Make of_find_next_cache_node() available for modules.
> 
> Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
> ---
>  drivers/of/base.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
