Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90B7F2FB44
	for <lists+linux-edac@lfdr.de>; Thu, 30 May 2019 13:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfE3L5d (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 30 May 2019 07:57:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:38058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726792AbfE3L5d (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 30 May 2019 07:57:33 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E614B253BD;
        Thu, 30 May 2019 11:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559217453;
        bh=6nakkgFOlBb6tykWloF+3IRNTh2N9WxQ6FnBheDM6co=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ItYDNrdsSW5lbjYeWlWir785To5jJK03JenekGpraZ5kt/FrcA9o3UxrSK+8+psBf
         YKZ4+pHPnRUKVa5EQAcMpP0iHTJ64G+KktH579NY/cyFKCst3C8ZqQ3uhWKtldsf1Q
         tqJt0PwPwl3o/WRaSKuSDZeEg97vjIu8LcyekWCk=
Date:   Thu, 30 May 2019 04:57:32 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hanna Hawa <hhhawa@amazon.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, bp@alien8.de,
        mchehab@kernel.org, james.morse@arm.com, davem@davemloft.net,
        nicolas.ferre@microchip.com, paulmck@linux.ibm.com,
        dwmw@amazon.co.uk, benh@amazon.com, ronenk@amazon.com,
        talel@amazon.com, jonnyc@amazon.com, hanochu@amazon.com,
        linux-edac@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] edac: add support for Amazon's Annapurna Labs EDAC
Message-ID: <20190530115732.GB14088@kroah.com>
References: <1559211329-13098-1-git-send-email-hhhawa@amazon.com>
 <1559211329-13098-3-git-send-email-hhhawa@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559211329-13098-3-git-send-email-hhhawa@amazon.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, May 30, 2019 at 01:15:29PM +0300, Hanna Hawa wrote:
> +static void al_a57_edac_cpumerrsr(void *arg)
> +{
> +	struct edac_device_ctl_info *edac_dev =
> +		(struct edac_device_ctl_info *)arg;

No need for casting anything here, just assign it.  Doesn't checkpatch
catch this type of thing these days?  You did run it, right?

Please fix that up everywhere you do this in the driver.


thanks,

greg k-h
