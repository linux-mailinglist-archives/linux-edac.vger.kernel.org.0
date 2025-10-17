Return-Path: <linux-edac+bounces-5112-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D81D9BE8A0B
	for <lists+linux-edac@lfdr.de>; Fri, 17 Oct 2025 14:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 927295E15A5
	for <lists+linux-edac@lfdr.de>; Fri, 17 Oct 2025 12:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7D932B986;
	Fri, 17 Oct 2025 12:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="1OrQ3YIQ"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEB332ABF0;
	Fri, 17 Oct 2025 12:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760705057; cv=none; b=de89S8fW1j8CJLEPErbvbM+4Efbc7EN/xicmfQb7WntuQMhIZNbVx6RLAY3SR5udfW44BLdzUHuCyBzqFOgdQvSFP5aKkx4A4F907980KVjndsVb+vF0V/qphdx55dvJDau+u7y+djb6MVPpiHc9OB0cGBK1QeuhrUIUrIxfdKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760705057; c=relaxed/simple;
	bh=BP2tLcRODLLTGYUQN3ZH9uxeI36susbN9rWaT61n7mw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q72ZQPS6G0MiEZDdvjZ0GgNKxORkjA/hPwW28D1ANEIOxiUGNSWGuwrEMmoN9O0wWYM8JMULUmIRJN0gtTIGTBSvzza4Y9ApBjtXBV3WJcGYYAjs5Saa69u4dd+XKGYhnTP1xI8rDxmXLSBCfCY8B+JeSVjS3+vB9UTAy1EDshM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=1OrQ3YIQ; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 893244E41141;
	Fri, 17 Oct 2025 12:44:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5A865606DB;
	Fri, 17 Oct 2025 12:44:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9F85E102F2354;
	Fri, 17 Oct 2025 14:43:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760705048; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=/PLeJE9KR8p3lxXJm49K9+lE+MUQWAG1Y2Q1wp2iOt0=;
	b=1OrQ3YIQQiPnuSNXZtkh4wYwdSdAx5UueEbM2yNm13HKZwXyw1ihYGUrNQYUdxkCpAGMVy
	YkkbIcpe0CR3qCP0wbMwh0zB1hOC7TqWWodn2WW8KY4xNUI/O+AOQw8TbYSSBrfGghbWHY
	8Gc/3LSoCg3bXhOMFn0hCZL3djPCGi05rhcyYi2XzvAHIj8BH3d3SHGs+YBu9weyvWUJj1
	4x9y5ZrJ27Kz0QSzL86mHytkuRU1hWZsMm0cuM7FT149jkBeSq2OjLIdD2HeCYXV3oJQhQ
	bghkZIB7Jr0R4y2M9IPMwRAhI867zJp19eaGdl5+XtIq6kavcMynCp7fukKm4Q==
Message-ID: <c3549740-f01c-4a98-8a3e-5af70326f0eb@bootlin.com>
Date: Fri, 17 Oct 2025 14:43:17 +0200
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] bitfield: Add non-constant field_{prep,get}()
 helpers
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, David Miller
 <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>,
 Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Johannes Berg <johannes@sipsolutions.net>, Jakub Kicinski <kuba@kernel.org>,
 Alex Elder <elder@ieee.org>, David Laight <david.laight.linux@gmail.com>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Jason Baron
 <jbaron@akamai.com>, Borislav Petkov <bp@alien8.de>,
 Tony Luck <tony.luck@intel.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Kim Seer Paller <kimseer.paller@analog.com>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Cosmin Tanislav <demonsingur@gmail.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Jianping Shen <Jianping.Shen@de.bosch.com>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-renesas-soc@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-edac@vger.kernel.org, qat-linux@intel.com, linux-gpio@vger.kernel.org,
 linux-aspeed@lists.ozlabs.org, linux-iio@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <cover.1760696560.git.geert+renesas@glider.be>
 <67c1998f144b3a21399672c8e4d58d3884ae2b3c.1760696560.git.geert+renesas@glider.be>
 <f2b879d3e8120c7aeb0e6c9a5fd45b15a2b8e5a0.camel@gmail.com>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <f2b879d3e8120c7aeb0e6c9a5fd45b15a2b8e5a0.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Le 17/10/2025 à 14:33, Nuno Sá a écrit :
> On Fri, 2025-10-17 at 12:54 +0200, Geert Uytterhoeven wrote:
>> The existing FIELD_{GET,PREP}() macros are limited to compile-time
>> constants.  However, it is very common to prepare or extract bitfield
>> elements where the bitfield mask is not a compile-time constant.
>>
>> To avoid this limitation, the AT91 clock driver and several other
>> drivers already have their own non-const field_{prep,get}() macros.
>> Make them available for general use by consolidating them in
>> <linux/bitfield.h>, and improve them slightly:
>>    1. Avoid evaluating macro parameters more than once,
>>    2. Replace "ffs() - 1" by "__ffs()",
>>    3. Support 64-bit use on 32-bit architectures.
>>
>> This is deliberately not merged into the existing FIELD_{GET,PREP}()
>> macros, as people expressed the desire to keep stricter variants for
>> increased safety, or for performance critical paths.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
>> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Acked-by: Crt Mori <cmo@melexis.com>
>> ---
> 
> Hopefully this gets merged soon. About time to have these variants (I do have a
> driver submitted - in review - which is adding yet another variant of this)
>   
> Acked-by: Nuno Sá <nuno.sa@analog.com>

Same here, I would happily drop field_{get,set} from my series under 
review to include bitfield.h
Thanks Geert!

Acked-by: Richard Genoud <richard.genoud@bootlin.com>

> 
>> v4:
>>    - Add Acked-by,
>>    - Rebase on top of commit 7c68005a46108ffa ("crypto: qat - relocate
>>      power management debugfs helper APIs") in v6.17-rc1,
>>    - Convert more recently introduced upstream copies:
>>        - drivers/edac/ie31200_edac.c
>>        - drivers/iio/dac/ad3530r.c
>>
>> v3:
>>    - Add Acked-by,
>>    - Drop underscores from macro parameters,
>>    - Use __auto_type where possible,
>>    - Correctly cast reg to the mask type,
>>    - Introduces __val and __reg intermediates to simplify the actual
>>      operation,
>>    - Drop unneeded parentheses,
>>    - Clarify having both FIELD_{GET,PREP}() and field_{get,prep}(),
>>
>> v2:
>>    - Cast val resp. reg to the mask type,
>>    - Fix 64-bit use on 32-bit architectures,
>>    - Convert new upstream users:
>>        - drivers/crypto/intel/qat/qat_common/adf_gen4_pm_debugfs.c
>>        - drivers/gpio/gpio-aspeed.c
>>        - drivers/iio/temperature/mlx90614.c
>>        - drivers/pinctrl/nuvoton/pinctrl-ma35.c
>>        - sound/usb/mixer_quirks.c
>>    - Convert new user queued in renesas-devel for v6.15:
>>        - drivers/soc/renesas/rz-sysc.c
>> ---
>>   drivers/clk/at91/clk-peripheral.c             |  1 +
>>   drivers/clk/at91/pmc.h                        |  3 --
>>   .../intel/qat/qat_common/adf_pm_dbgfs_utils.c |  8 +----
>>   drivers/edac/ie31200_edac.c                   |  4 +--
>>   drivers/gpio/gpio-aspeed.c                    |  5 +--
>>   drivers/iio/dac/ad3530r.c                     |  3 --
>>   drivers/iio/temperature/mlx90614.c            |  5 +--
>>   drivers/pinctrl/nuvoton/pinctrl-ma35.c        |  4 ---
>>   drivers/soc/renesas/rz-sysc.c                 |  3 +-
>>   include/linux/bitfield.h                      | 36 +++++++++++++++++++
>>   sound/usb/mixer_quirks.c                      |  4 ---
>>   11 files changed, 42 insertions(+), 34 deletions(-)
>>
>> diff --git a/drivers/clk/at91/clk-peripheral.c b/drivers/clk/at91/clk-
>> peripheral.c
>> index e700f40fd87f9327..e7208c47268b6397 100644
>> --- a/drivers/clk/at91/clk-peripheral.c
>> +++ b/drivers/clk/at91/clk-peripheral.c
>> @@ -3,6 +3,7 @@
>>    *  Copyright (C) 2013 Boris BREZILLON <b.brezillon@overkiz.com>
>>    */
>>   
>> +#include <linux/bitfield.h>
>>   #include <linux/bitops.h>
>>   #include <linux/clk-provider.h>
>>   #include <linux/clkdev.h>
>> diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
>> index 5daa32c4cf2540d7..543d7aee8d248cdb 100644
>> --- a/drivers/clk/at91/pmc.h
>> +++ b/drivers/clk/at91/pmc.h
>> @@ -117,9 +117,6 @@ struct at91_clk_pms {
>>   	unsigned int parent;
>>   };
>>   
>> -#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
>> -#define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
>> -
>>   #define ndck(a, s) (a[s - 1].id + 1)
>>   #define nck(a) (a[ARRAY_SIZE(a) - 1].id + 1)
>>   
>> diff --git a/drivers/crypto/intel/qat/qat_common/adf_pm_dbgfs_utils.c
>> b/drivers/crypto/intel/qat/qat_common/adf_pm_dbgfs_utils.c
>> index 69295a9ddf0ac92f..4ccc94ed9493a64c 100644
>> --- a/drivers/crypto/intel/qat/qat_common/adf_pm_dbgfs_utils.c
>> +++ b/drivers/crypto/intel/qat/qat_common/adf_pm_dbgfs_utils.c
>> @@ -1,18 +1,12 @@
>>   // SPDX-License-Identifier: GPL-2.0-only
>>   /* Copyright(c) 2025 Intel Corporation */
>> +#include <linux/bitfield.h>
>>   #include <linux/bitops.h>
>>   #include <linux/sprintf.h>
>>   #include <linux/string_helpers.h>
>>   
>>   #include "adf_pm_dbgfs_utils.h"
>>   
>> -/*
>> - * This is needed because a variable is used to index the mask at
>> - * pm_scnprint_table(), making it not compile time constant, so the compile
>> - * asserts from FIELD_GET() or u32_get_bits() won't be fulfilled.
>> - */
>> -#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
>> -
>>   #define PM_INFO_MAX_KEY_LEN	21
>>   
>>   static int pm_scnprint_table(char *buff, const struct pm_status_row *table,
>> diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
>> index 5a080ab65476dacf..dfc9a9cecd74207d 100644
>> --- a/drivers/edac/ie31200_edac.c
>> +++ b/drivers/edac/ie31200_edac.c
>> @@ -44,6 +44,7 @@
>>    * but lo_hi_readq() ensures that we are safe across all e3-1200 processors.
>>    */
>>   
>> +#include <linux/bitfield.h>
>>   #include <linux/module.h>
>>   #include <linux/init.h>
>>   #include <linux/pci.h>
>> @@ -139,9 +140,6 @@
>>   #define IE31200_CAPID0_DDPCD		BIT(6)
>>   #define IE31200_CAPID0_ECC		BIT(1)
>>   
>> -/* Non-constant mask variant of FIELD_GET() */
>> -#define field_get(_mask, _reg)  (((_reg) & (_mask)) >> (ffs(_mask) - 1))
>> -
>>   static int nr_channels;
>>   static struct pci_dev *mci_pdev;
>>   static int ie31200_registered = 1;
>> diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
>> index 7953a9c4e36d7550..3da999334971d501 100644
>> --- a/drivers/gpio/gpio-aspeed.c
>> +++ b/drivers/gpio/gpio-aspeed.c
>> @@ -5,6 +5,7 @@
>>    * Joel Stanley <joel@jms.id.au>
>>    */
>>   
>> +#include <linux/bitfield.h>
>>   #include <linux/cleanup.h>
>>   #include <linux/clk.h>
>>   #include <linux/gpio/aspeed.h>
>> @@ -31,10 +32,6 @@
>>   #include <linux/gpio/consumer.h>
>>   #include "gpiolib.h"
>>   
>> -/* Non-constant mask variant of FIELD_GET() and FIELD_PREP() */
>> -#define field_get(_mask, _reg)	(((_reg) & (_mask)) >> (ffs(_mask) - 1))
>> -#define field_prep(_mask, _val)	(((_val) << (ffs(_mask) - 1)) &
>> (_mask))
>> -
>>   #define GPIO_G7_IRQ_STS_BASE 0x100
>>   #define GPIO_G7_IRQ_STS_OFFSET(x) (GPIO_G7_IRQ_STS_BASE + (x) * 0x4)
>>   #define GPIO_G7_CTRL_REG_BASE 0x180
>> diff --git a/drivers/iio/dac/ad3530r.c b/drivers/iio/dac/ad3530r.c
>> index 6134613777b8e1d4..b97b46090d808ee7 100644
>> --- a/drivers/iio/dac/ad3530r.c
>> +++ b/drivers/iio/dac/ad3530r.c
>> @@ -53,9 +53,6 @@
>>   #define AD3530R_MAX_CHANNELS			8
>>   #define AD3531R_MAX_CHANNELS			4
>>   
>> -/* Non-constant mask variant of FIELD_PREP() */
>> -#define field_prep(_mask, _val)	(((_val) << (ffs(_mask) - 1)) &
>> (_mask))
>> -
>>   enum ad3530r_mode {
>>   	AD3530R_NORMAL_OP,
>>   	AD3530R_POWERDOWN_1K,
>> diff --git a/drivers/iio/temperature/mlx90614.c
>> b/drivers/iio/temperature/mlx90614.c
>> index 8a44a00bfd5ece38..1ad21b73e1b44cb0 100644
>> --- a/drivers/iio/temperature/mlx90614.c
>> +++ b/drivers/iio/temperature/mlx90614.c
>> @@ -22,6 +22,7 @@
>>    * the "wakeup" GPIO is not given, power management will be disabled.
>>    */
>>   
>> +#include <linux/bitfield.h>
>>   #include <linux/delay.h>
>>   #include <linux/err.h>
>>   #include <linux/gpio/consumer.h>
>> @@ -68,10 +69,6 @@
>>   #define MLX90614_CONST_SCALE 20 /* Scale in milliKelvin (0.02 * 1000) */
>>   #define MLX90614_CONST_FIR 0x7 /* Fixed value for FIR part of low pass filter
>> */
>>   
>> -/* Non-constant mask variant of FIELD_GET() and FIELD_PREP() */
>> -#define field_get(_mask, _reg)	(((_reg) & (_mask)) >> (ffs(_mask) - 1))
>> -#define field_prep(_mask, _val)	(((_val) << (ffs(_mask) - 1)) &
>> (_mask))
>> -
>>   struct mlx_chip_info {
>>   	/* EEPROM offsets with 16-bit data, MSB first */
>>   	/* emissivity correction coefficient */
>> diff --git a/drivers/pinctrl/nuvoton/pinctrl-ma35.c
>> b/drivers/pinctrl/nuvoton/pinctrl-ma35.c
>> index cdad01d68a37e365..8d71dc53cc1de1f8 100644
>> --- a/drivers/pinctrl/nuvoton/pinctrl-ma35.c
>> +++ b/drivers/pinctrl/nuvoton/pinctrl-ma35.c
>> @@ -81,10 +81,6 @@
>>   #define MVOLT_1800			0
>>   #define MVOLT_3300			1
>>   
>> -/* Non-constant mask variant of FIELD_GET() and FIELD_PREP() */
>> -#define field_get(_mask, _reg)	(((_reg) & (_mask)) >> (ffs(_mask) - 1))
>> -#define field_prep(_mask, _val)	(((_val) << (ffs(_mask) - 1)) &
>> (_mask))
>> -
>>   static const char * const gpio_group_name[] = {
>>   	"gpioa", "gpiob", "gpioc", "gpiod", "gpioe", "gpiof", "gpiog",
>>   	"gpioh", "gpioi", "gpioj", "gpiok", "gpiol", "gpiom", "gpion",
>> diff --git a/drivers/soc/renesas/rz-sysc.c b/drivers/soc/renesas/rz-sysc.c
>> index 9f79e299e6f41641..73eaf8b9d69f7208 100644
>> --- a/drivers/soc/renesas/rz-sysc.c
>> +++ b/drivers/soc/renesas/rz-sysc.c
>> @@ -5,6 +5,7 @@
>>    * Copyright (C) 2024 Renesas Electronics Corp.
>>    */
>>   
>> +#include <linux/bitfield.h>
>>   #include <linux/cleanup.h>
>>   #include <linux/io.h>
>>   #include <linux/mfd/syscon.h>
>> @@ -16,8 +17,6 @@
>>   
>>   #include "rz-sysc.h"
>>   
>> -#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
>> -
>>   /**
>>    * struct rz_sysc - RZ SYSC private data structure
>>    * @base: SYSC base address
>> diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
>> index 7ff817bdae19b468..c999fe70076f6684 100644
>> --- a/include/linux/bitfield.h
>> +++ b/include/linux/bitfield.h
>> @@ -220,4 +220,40 @@ __MAKE_OP(64)
>>   #undef __MAKE_OP
>>   #undef ____MAKE_OP
>>   
>> +/**
>> + * field_prep() - prepare a bitfield element
>> + * @mask: shifted mask defining the field's length and position
>> + * @val:  value to put in the field
>> + *
>> + * field_prep() masks and shifts up the value.  The result should be
>> + * combined with other fields of the bitfield using logical OR.
>> + * Unlike FIELD_PREP(), @mask is not limited to a compile-time constant.
>> + */
>> +#define field_prep(mask, val)						\
>> +	({								\
>> +		__auto_type __mask = (mask);				\
>> +		typeof(mask) __val = (val);				\
>> +		unsigned int __shift = sizeof(mask) <= 4 ?		\
>> +				       __ffs(__mask) :
>> __ffs64(__mask);	\
>> +		(__val << __shift) & __mask;	\
>> +	})
>> +
>> +/**
>> + * field_get() - extract a bitfield element
>> + * @mask: shifted mask defining the field's length and position
>> + * @reg:  value of entire bitfield
>> + *
>> + * field_get() extracts the field specified by @mask from the
>> + * bitfield passed in as @reg by masking and shifting it down.
>> + * Unlike FIELD_GET(), @mask is not limited to a compile-time constant.
>> + */
>> +#define field_get(mask, reg)						\
>> +	({								\
>> +		__auto_type __mask = (mask);				\
>> +		typeof(mask) __reg =  (reg);				\
>> +		unsigned int __shift = sizeof(mask) <= 4 ?		\
>> +				       __ffs(__mask) :
>> __ffs64(__mask);	\
>> +		(__reg & __mask) >> __shift;	\
>> +	})
>> +
>>   #endif
>> diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
>> index 828af3095b86ee0a..6eee89cbc0867f2b 100644
>> --- a/sound/usb/mixer_quirks.c
>> +++ b/sound/usb/mixer_quirks.c
>> @@ -3311,10 +3311,6 @@ static int snd_bbfpro_controls_create(struct
>> usb_mixer_interface *mixer)
>>   #define RME_DIGIFACE_REGISTER(reg, mask) (((reg) << 16) | (mask))
>>   #define RME_DIGIFACE_INVERT BIT(31)
>>   
>> -/* Nonconst helpers */
>> -#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
>> -#define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
>> -
>>   static int snd_rme_digiface_write_reg(struct snd_kcontrol *kcontrol, int
>> item, u16 mask, u16 val)
>>   {
>>   	struct usb_mixer_elem_list *list = snd_kcontrol_chip(kcontrol);


-- 
Richard Genoud, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

