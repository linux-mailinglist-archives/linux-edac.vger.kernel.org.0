Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2873EDF360
	for <lists+linux-edac@lfdr.de>; Mon, 21 Oct 2019 18:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfJUQnQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 21 Oct 2019 12:43:16 -0400
Received: from [217.140.110.172] ([217.140.110.172]:58012 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1727582AbfJUQnQ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 21 Oct 2019 12:43:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C4F916F8;
        Mon, 21 Oct 2019 09:42:53 -0700 (PDT)
Received: from [10.1.196.105] (unknown [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CCF4D3F71F;
        Mon, 21 Oct 2019 09:42:48 -0700 (PDT)
Subject: Re: [PATCH v6 2/2] soc: amazon: al-pos-edac: Introduce Amazon's
 Annapurna Labs POS EDAC driver
To:     Talel Shenhar <talel@amazon.com>
Cc:     robh+dt@kernel.org, maz@kernel.org, mark.rutland@arm.com,
        arnd@arndb.de, bp@alien8.de, mchehab@kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        paulmck@linux.ibm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        dwmw@amazon.co.uk, benh@kernel.crashing.org, hhhawa@amazon.com,
        ronenk@amazon.com, jonnyc@amazon.com, hanochu@amazon.com,
        amirkl@amazon.com, barakw@amazon.com
References: <1570707681-865-1-git-send-email-talel@amazon.com>
 <1570707681-865-3-git-send-email-talel@amazon.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <e66ff9b9-5fcb-e746-a551-2dc76bbeab48@arm.com>
Date:   Mon, 21 Oct 2019 17:42:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1570707681-865-3-git-send-email-talel@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Talel,

On 10/10/2019 12:41, Talel Shenhar wrote:
> The Amazon's Annapurna Labs SoCs includes Point Of Serialization error
> logging unit that reports an error in case write error (e.g . Attempt to

(This is tricky to parse. "error in case write error" -> "error when a write error occurs"?)

> write to a read only register).
> This error shall be reported to EDAC subsystem as uncorrectable-error.


> diff --git a/MAINTAINERS b/MAINTAINERS
> index 55199ef..a77d554 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -757,6 +757,13 @@ F:	drivers/tty/serial/altera_jtaguart.c
>  F:	include/linux/altera_uart.h
>  F:	include/linux/altera_jtaguart.h
>  
> +AMAZON ANNAPURNA LABS POS EDAC DRIVER
> +M:	Talel Shenhar <talel@amazon.com>
> +M:	Talel Shenhar <talelshenhar@gmail.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/edac/amazon,al-pos-edac.yaml

> +F:	drivers/edac/al-pos-edac.c

~s/-/_/


> diff --git a/drivers/edac/al_pos_edac.c b/drivers/edac/al_pos_edac.c
> new file mode 100644
> index 00000000..a85ab67
> --- /dev/null
> +++ b/drivers/edac/al_pos_edac.c
> @@ -0,0 +1,173 @@

> +static int al_pos_handle(struct al_pos_edac *al_pos)
> +{

> +	log1 = readl_relaxed(al_pos->mmio_base + AL_POS_ERROR_LOG_1);
> +	if (!FIELD_GET(AL_POS_ERROR_LOG_1_VALID, log1))
> +		return 0;

[...]

> +	edac_device_handle_ue(al_pos->edac_dev, 0, 0, msg);
> +
> +	return 1;
> +}
[...]

> +static irqreturn_t al_pos_irq_handler(int irq, void *info)
> +{

> +	if (al_pos_handle(al_pos))
> +		return IRQ_HANDLED;
> +	return IRQ_NONE;
> +}


> +static int al_pos_probe(struct platform_device *pdev)
> +{
> +	struct edac_device_ctl_info *edac_dev;
> +	struct al_pos_edac *al_pos;
> +	int ret;
> +
> +	edac_dev = edac_device_alloc_ctl_info(sizeof(*al_pos), DRV_NAME, 1,
> +					      DRV_NAME, 1, 0, NULL, 0,
> +					      edac_device_alloc_index());
> +	if (!edac_dev)
> +		return -ENOMEM;
> +
> +	al_pos = edac_dev->pvt_info;
> +	al_pos->edac_dev = edac_dev;
> +	platform_set_drvdata(pdev, al_pos);
> +
> +	al_pos->mmio_base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(al_pos->mmio_base)) {
> +		dev_err(&pdev->dev, "failed to ioremap memory (%ld)\n",
> +			PTR_ERR(al_pos->mmio_base));

edac_device_free_ctl_info(al_pos->edac_dev) or goto err_free_edac ?

> +		return PTR_ERR(al_pos->mmio_base);
> +	}
> +
> +	al_pos->irq = platform_get_irq(pdev, 0);
> +	if (al_pos->irq <= 0)
> +		edac_dev->edac_check = al_pos_edac_check;
> +
> +	edac_dev->dev = &pdev->dev;
> +	edac_dev->mod_name = DRV_NAME;
> +	edac_dev->dev_name = dev_name(&pdev->dev);
> +	edac_dev->ctl_name = "POS";

Does this show up in sysfs? The 'AL_' prefix may make it easier to find the corresponding
driver. (The TLA space is a little crowded!)


> +	ret = edac_device_add_device(edac_dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to add edac device\n");
> +		goto err_free_edac;
> +	}
> +
> +	if (al_pos->irq > 0) {
> +		ret = devm_request_irq(&pdev->dev,
> +				       al_pos->irq,
> +				       al_pos_irq_handler,

> +				       0,

Can this be IRQF_SHARED? This lets other devices register the interrupt too, which is
easily allowed if you can identify whether your device has triggered the interrupt. (which
you are already doing with the valid bit in your log1 register).


> +				       pdev->name,
> +				       pdev);
> +		if (ret != 0) {
> +			dev_err(&pdev->dev,
> +				"failed to register to irq %d (%d)\n",
> +				al_pos->irq, ret);
> +			goto err_remove_edac;
> +		}
> +	}
> +
> +	return 0;
> +
> +err_remove_edac:
> +	edac_device_del_device(edac_dev->dev);
> +err_free_edac:
> +	edac_device_free_ctl_info(edac_dev);
> +
> +	return ret;
> +}


With the edac_dev-leak fixed and the -/_ in MAINTAINERS:

Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James
