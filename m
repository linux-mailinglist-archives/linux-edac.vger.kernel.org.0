Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03B7C11BD0D
	for <lists+linux-edac@lfdr.de>; Wed, 11 Dec 2019 20:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfLKTdU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 11 Dec 2019 14:33:20 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39312 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbfLKTdU (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 11 Dec 2019 14:33:20 -0500
Received: by mail-lj1-f195.google.com with SMTP id e10so25385946ljj.6
        for <linux-edac@vger.kernel.org>; Wed, 11 Dec 2019 11:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mCFBeOM7voY1Ap11AuqjB0+8nGe8UCHSkrpkRbOs5Ew=;
        b=mgYXhIwqY2wQSccMDOUbOyikGEbtRMsAkjSRmXtyRnv6J8O+j3l4+72bkVAO4tN+E/
         uBM2uS703083d5xdjOFFu/1f0HUidbSIDLHr5yEXBiadR1mWfxqz6masOyEvq9v37Jzq
         wyqX1KqDlHSwLc9aIgjNvp8sZBRhDw3/Fydpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mCFBeOM7voY1Ap11AuqjB0+8nGe8UCHSkrpkRbOs5Ew=;
        b=bBVV/hwfisx8x3NqmtTh9x9dNBVO+4pbdXFkJ8BxBkhlgxvKzSrWuGCwZK0zEqUEMG
         i9jxGcbEtPxCTZc7v+s2k1B4ImDVXLk3blHBZGXw2i0lBXsBPi+qDGXROaWV6yjgE6V6
         pH1q1uB4SVCK43IQj4qmFXuRXSBl+gfD7S4zC9NREb1j9/6Ss8dIpWmHoEue24akyJpZ
         ZX6s+CmDMn6LeTiuGuukg8NhqmAnUpC/YwIGqxu8e57FyMxoiQqCD8PHtWza8ZlW4Zwo
         LU42DvMn53UJTH3RU0/gDV94GC7DibL1mkKBUlLeFgIkyvVC83SAcQ8Q0zKcAmfZWk6n
         r8hg==
X-Gm-Message-State: APjAAAUFMupWwA0zW9SxVUsBBY95nJ76d18tL9hp+HO798kj+RmANFmD
        fkbejmvHmY1j8aqRqRXI9M31WCdERPk=
X-Google-Smtp-Source: APXvYqxoB4yESRIdwcRNtNj8r9FNQaD+ltErCnWfypr/eUujU+bE8EUcw+nejnFgrU2g4d/G7FT1Sg==
X-Received: by 2002:a2e:9284:: with SMTP id d4mr3351449ljh.226.1576092796042;
        Wed, 11 Dec 2019 11:33:16 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id w71sm1951031lff.0.2019.12.11.11.33.14
        for <linux-edac@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 11:33:14 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id f15so16782862lfl.13
        for <linux-edac@vger.kernel.org>; Wed, 11 Dec 2019 11:33:14 -0800 (PST)
X-Received: by 2002:ac2:52a3:: with SMTP id r3mr3390323lfm.189.1576092793705;
 Wed, 11 Dec 2019 11:33:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1575529553.git.saiprakash.ranjan@codeaurora.org> <0101016ed57a6311-e815485c-4b77-4342-a3de-203673941602-000000@us-west-2.amazonses.com>
In-Reply-To: <0101016ed57a6311-e815485c-4b77-4342-a3de-203673941602-000000@us-west-2.amazonses.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 11 Dec 2019 11:32:37 -0800
X-Gmail-Original-Message-ID: <CAE=gft5JvCegmrjkKuxYr9dgASPFCkgy97O1XGRyKDF6xT=BMA@mail.gmail.com>
Message-ID: <CAE=gft5JvCegmrjkKuxYr9dgASPFCkgy97O1XGRyKDF6xT=BMA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drivers: edac: Add EDAC support for Kryo CPU caches
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        linux-edac@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, tsoni@codeaurora.org,
        psodagud@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Sai,

On Thu, Dec 5, 2019 at 1:53 AM Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> Kryo{3,4}XX CPU cores implement RAS extensions to support
> Error Correcting Code(ECC). Currently all Kryo{3,4}XX CPU
> cores (gold/silver a.k.a big/LITTLE) support ECC via RAS.
> This adds an interrupt based driver for those CPUs and
> provides an optional polling of error recording system
> registers.
>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>  MAINTAINERS                   |   7 +
>  drivers/edac/Kconfig          |  20 +
>  drivers/edac/Makefile         |   1 +
>  drivers/edac/qcom_kryo_edac.c | 679 ++++++++++++++++++++++++++++++++++
>  4 files changed, 707 insertions(+)
>  create mode 100644 drivers/edac/qcom_kryo_edac.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c2d80079dccc..f58c93f963f6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6049,6 +6049,13 @@ L:       linux-edac@vger.kernel.org
>  S:     Maintained
>  F:     drivers/edac/qcom_edac.c
>
> +EDAC-KRYO-QCOM
> +M:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> +L:     linux-arm-msm@vger.kernel.org
> +L:     linux-edac@vger.kernel.org
> +S:     Maintained
> +F:     drivers/edac/qcom_kryo_edac.c
> +
>  EDIROL UA-101/UA-1000 DRIVER
>  M:     Clemens Ladisch <clemens@ladisch.de>
>  L:     alsa-devel@alsa-project.org (moderated for non-subscribers)
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 417dad635526..cd78ac2917c9 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -508,6 +508,26 @@ config EDAC_QCOM
>           For debugging issues having to do with stability and overall system
>           health, you should probably say 'Y' here.
>
> +config EDAC_QCOM_KRYO
> +       tristate "QCOM Kryo EDAC for CPU L1/L2/L3-SCU caches"
> +       depends on ARCH_QCOM && ARM64_RAS_EXTN
> +       help
> +         Support for Error detection and correction on Kryo Gold and Silver CPU
> +         cores with RAS extensions. Currently it detects and reports all Single
> +         Bit Errors (SBEs) and Double Bit Errors (DBEs).
> +
> +         For debugging issues having to do with stability and overall system
> +         health, you should probably say 'Y' here.
> +
> +config EDAC_QCOM_KRYO_POLL
> +       depends on EDAC_QCOM_KRYO
> +       bool "Poll on Kryo ECC registers"
> +       help
> +         This option chooses whether or not you want to poll on the Kryo ECC
> +         registers. When this is enabled, the polling rate can be set as a
> +         module parameter. By default, it will call the polling function every
> +         second.
> +
>  config EDAC_ASPEED
>         tristate "Aspeed AST 2500 SoC"
>         depends on MACH_ASPEED_G5
> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
> index d77200c9680b..29edcfa6ec0e 100644
> --- a/drivers/edac/Makefile
> +++ b/drivers/edac/Makefile
> @@ -85,5 +85,6 @@ obj-$(CONFIG_EDAC_SYNOPSYS)           += synopsys_edac.o
>  obj-$(CONFIG_EDAC_XGENE)               += xgene_edac.o
>  obj-$(CONFIG_EDAC_TI)                  += ti_edac.o
>  obj-$(CONFIG_EDAC_QCOM)                        += qcom_edac.o
> +obj-$(CONFIG_EDAC_QCOM_KRYO)           += qcom_kryo_edac.o
>  obj-$(CONFIG_EDAC_ASPEED)              += aspeed_edac.o
>  obj-$(CONFIG_EDAC_BLUEFIELD)           += bluefield_edac.o
> diff --git a/drivers/edac/qcom_kryo_edac.c b/drivers/edac/qcom_kryo_edac.c
> new file mode 100644
> index 000000000000..05b60ad3cb0e
> --- /dev/null
> +++ b/drivers/edac/qcom_kryo_edac.c
> @@ -0,0 +1,679 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2019, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/cpu_pm.h>
> +#include <linux/of_irq.h>
> +#include <linux/smp.h>
> +
> +#include <asm/cputype.h>
> +#include <asm/sysreg.h>
> +
> +#include "edac_device.h"
> +#include "edac_mc.h"
> +
> +#define DRV_NAME               "qcom_kryo_edac"
> +
> +/*
> + * ARM Cortex-A55, Cortex-A75, Cortex-A76 TRM Chapter B3.3
> + * ARM DSU TRM Chapter B2.3
> + * CFI = Corrected Fault Handling interrupt, FI = Fault handling interrupt
> + * UI = Uncorrected error recovery interrupt, ED = Error Detection
> + */
> +#define KRYO_ERRXCTLR_ED       BIT(0)
> +#define KRYO_ERRXCTLR_UI       BIT(2)
> +#define KRYO_ERRXCTLR_FI       BIT(3)
> +#define KRYO_ERRXCTLR_CFI      BIT(8)
> +#define KRYO_ERRXCTLR_ENABLE   (KRYO_ERRXCTLR_CFI | KRYO_ERRXCTLR_FI | \
> +                                KRYO_ERRXCTLR_UI | KRYO_ERRXCTLR_ED)
> +
> +/*
> + * ARM Cortex-A55, Cortex-A75, Cortex-A76 TRM Chapter B3.4
> + * ARM DSU TRM Chapter B2.4
> + */
> +#define KRYO_ERRXFR_ED         GENMASK(1, 0)
> +#define KRYO_ERRXFR_DE         GENMASK(3, 2)
> +#define KRYO_ERRXFR_UI         GENMASK(5, 4)
> +#define KRYO_ERRXFR_FI         GENMASK(7, 6)
> +#define KRYO_ERRXFR_UE         GENMASK(9, 8)
> +#define KRYO_ERRXFR_CFI                GENMASK(11, 10)
> +#define KRYO_ERRXFR_CEC                GENMASK(14, 12)
> +#define KRYO_ERRXFR_RP         BIT(15)
> +#define KRYO_ERRXFR_SUPPORTED  (KRYO_ERRXFR_ED | KRYO_ERRXFR_DE | \
> +                                KRYO_ERRXFR_UI | KRYO_ERRXFR_FI | \
> +                                KRYO_ERRXFR_UE | KRYO_ERRXFR_CFI | \
> +                                KRYO_ERRXFR_CEC | KRYO_ERRXFR_RP)
> +
> +/*
> + * ARM Cortex-A55, Cortex-A75, Cortex-A76 TRM Chapter B3.5
> + * ARM DSU TRM Chapter B2.5
> + */
> +#define KRYO_ERRXMISC0_CECR    GENMASK_ULL(38, 32)
> +#define KRYO_ERRXMISC0_CECO    GENMASK_ULL(46, 40)
> +
> +/* ARM Cortex-A76 TRM Chapter B3.5 */
> +#define KRYO_ERRXMISC0_UNIT    GENMASK(3, 0)
> +#define KRYO_ERRXMISC0_LVL     GENMASK(3, 1)
> +
> +/* ARM Cortex-A76 TRM Chapter B3.10 has SERR bitfields 4:0
> + * but Cortex-A55, Cortex-A75 and DSU TRM has SERR bitfields 7:0.
> + * Since max error record is 21, we can use bitfields 4:0 for
> + * Kryo{3,4}XX CPUs.
> + */
> +#define KRYO_ERRXSTATUS_SERR   GENMASK(4, 0)
> +#define KRYO_ERRXSTATUS_DE     BIT(23)
> +#define KRYO_ERRXSTATUS_CE     GENMASK(25, 24)
> +#define KRYO_ERRXSTATUS_MV     BIT(26)
> +#define KRYO_ERRXSTATUS_UE     BIT(29)
> +#define KRYO_ERRXSTATUS_VALID  BIT(30)
> +
> +/* ARM Cortex-A76 TRM Chapter B3.5
> + * IC = Instruction Cache, DC = Data Cache
> + */
> +#define KRYO_L1_UNIT_IC                0x1
> +#define KRYO_L2_UNIT_TLB       0x2
> +#define KRYO_L1_UNIT_DC                0x4
> +#define KRYO_L2_UNIT           0x8
> +
> +/*
> + * ARM Cortex-A55 TRM Chapter B2.36
> + * ARM Cortex-A75, Cortex-A76 TRM Chapter B2.37
> + */
> +#define KRYO_ERR_RECORD_L1_L2  0x0
> +#define KRYO_ERR_RECORD_L3     0x1
> +
> +/* ARM DSU TRM Chapter B2.10 */
> +#define BUS_ERROR              0x12
> +
> +/* QCOM Kryo CPU part numbers */
> +#define KRYO3XX_GOLD           0x802
> +#define KRYO4XX_GOLD           0x804
> +#define KRYO4XX_SILVER_V1      0x803
> +#define KRYO4XX_SILVER_V2      0x805
> +
> +#define KRYO_EDAC_MSG_MAX      256
> +
> +static int poll_msec = 1000;
> +module_param(poll_msec, int, 0444);
> +
> +enum {
> +       KRYO_L1 = 0,
> +       KRYO_L2,
> +       KRYO_L3,
> +};
> +
> +/* CE = Corrected Error, UE = Uncorrected Error, DE = Deferred Error */
> +enum {

No name?

> +       KRYO_L1_CE = 0,
> +       KRYO_L1_UE,
> +       KRYO_L1_DE,
> +       KRYO_L2_CE,
> +       KRYO_L2_UE,
> +       KRYO_L2_DE,
> +       KRYO_L3_CE,
> +       KRYO_L3_UE,
> +       KRYO_L3_DE,
> +};
> +
> +struct error_record {
> +       u32 error_code;
> +       const char *error_msg;
> +};
> +
> +struct error_type {
> +       void (*fn)(struct edac_device_ctl_info *edev_ctl,
> +                  int inst_nr, int block_nr, const char *msg);
> +       const char *msg;
> +};
> +
> +/*
> + * ARM Cortex-A55, Cortex-A75, Cortex-A76 TRM Chapter B3.10
> + * ARM DSU TRM Chapter B2.10
> + */
> +static const struct error_record serror_record[] = {
> +       { 0x1,  "Errors due to fault injection"         },
> +       { 0x2,  "ECC error from internal data buffer"   },
> +       { 0x6,  "ECC error on cache data RAM"           },
> +       { 0x7,  "ECC error on cache tag or dirty RAM"   },
> +       { 0x8,  "Parity error on TLB data RAM"          },
> +       { 0x9,  "Parity error on TLB tag RAM"           },
> +       { 0x12, "Error response for a cache copyback"   },
> +       { 0x15, "Deferred error not supported"          },
> +};
> +
> +static const struct error_type err_type[] = {
> +       { edac_device_handle_ce, "Kryo L1 Corrected Error"      },
> +       { edac_device_handle_ue, "Kryo L1 Uncorrected Error"    },
> +       { edac_device_handle_ue, "Kryo L1 Deferred Error"       },
> +       { edac_device_handle_ce, "Kryo L2 Corrected Error"      },
> +       { edac_device_handle_ue, "Kryo L2 Uncorrected Error"    },
> +       { edac_device_handle_ue, "Kryo L2 Deferred Error"       },
> +       { edac_device_handle_ce, "L3 Corrected Error"           },
> +       { edac_device_handle_ue, "L3 Uncorrected Error"         },
> +       { edac_device_handle_ue, "L3 Deferred Error"            },
> +};

A comment is warranted to indicate that err_type is indexed by the
enum, as this would be easy to mess up in later changes.

> +
> +static struct edac_device_ctl_info __percpu *edac_dev;
> +static struct edac_device_ctl_info *drv_edev_ctl;
> +
> +static const char *get_error_msg(u64 errxstatus)
> +{
> +       const struct error_record *rec;
> +       u32 errxstatus_serr;
> +
> +       errxstatus_serr = FIELD_GET(KRYO_ERRXSTATUS_SERR, errxstatus);
> +
> +       for (rec = serror_record; rec->error_code; rec++) {

It looks like you expect the table to be zero terminated, but it's
not. Add the missing zero entry.

> +               if (errxstatus_serr == rec->error_code)
> +                       return rec->error_msg;
> +       }
> +
> +       return NULL;
> +}
> +
> +static void dump_syndrome_reg(int error_type, int level,
> +                             u64 errxstatus, u64 errxmisc,
> +                             struct edac_device_ctl_info *edev_ctl)
> +{
> +       char msg[KRYO_EDAC_MSG_MAX];
> +       const char *error_msg;
> +       int cpu;
> +
> +       cpu = raw_smp_processor_id();
> +
> +       error_msg = get_error_msg(errxstatus);
> +       if (!error_msg)
> +               return;
> +
> +       snprintf(msg, KRYO_EDAC_MSG_MAX,
> +                "CPU%d: %s, ERRXSTATUS_EL1:%#llx ERRXMISC0_EL1:%#llx, %s",
> +                cpu, err_type[error_type].msg, errxstatus, errxmisc,
> +                error_msg);
> +
> +       err_type[error_type].fn(edev_ctl, 0, level, msg);
> +}
> +
> +static void kryo_check_err_type(u64 errxstatus, u64 errxmisc,
> +                               struct edac_device_ctl_info *edev_ctl,
> +                               int level)
> +{
> +       u32 errxstatus_ue, errxstatus_ce, errxstatus_de;
> +
> +       errxstatus_ce = FIELD_GET(KRYO_ERRXSTATUS_CE, errxstatus);
> +       errxstatus_ue = FIELD_GET(KRYO_ERRXSTATUS_UE, errxstatus);
> +       errxstatus_de = FIELD_GET(KRYO_ERRXSTATUS_DE, errxstatus);
> +
> +       switch (level) {
> +       case KRYO_L1:
> +               if (errxstatus_ce)
> +                       dump_syndrome_reg(KRYO_L1_CE, level, errxstatus,
> +                                         errxmisc, edev_ctl);
> +               else if (errxstatus_ue)
> +                       dump_syndrome_reg(KRYO_L1_UE, level, errxstatus,
> +                                         errxmisc, edev_ctl);
> +               else if (errxstatus_de)
> +                       dump_syndrome_reg(KRYO_L1_DE, level, errxstatus,
> +                                         errxmisc, edev_ctl);
> +               else
> +                       edac_printk(KERN_ERR, DRV_NAME, "Unknown error\n");
> +               break;
> +       case KRYO_L2:
> +               if (errxstatus_ce)
> +                       dump_syndrome_reg(KRYO_L2_CE, level, errxstatus,
> +                                         errxmisc, edev_ctl);
> +               else if (errxstatus_ue)
> +                       dump_syndrome_reg(KRYO_L2_UE, level, errxstatus,
> +                                         errxmisc, edev_ctl);
> +               else if (errxstatus_de)
> +                       dump_syndrome_reg(KRYO_L2_DE, level, errxstatus,
> +                                         errxmisc, edev_ctl);
> +               else
> +                       edac_printk(KERN_ERR, DRV_NAME, "Unknown error\n");
> +               break;
> +       case KRYO_L3:
> +               if (errxstatus_ce)
> +                       dump_syndrome_reg(KRYO_L3_CE, level, errxstatus,
> +                                         errxmisc, edev_ctl);
> +               else if (errxstatus_ue)
> +                       dump_syndrome_reg(KRYO_L3_UE, level, errxstatus,
> +                                         errxmisc, edev_ctl);
> +               else if (errxstatus_de)
> +                       dump_syndrome_reg(KRYO_L3_DE, level, errxstatus,
> +                                         errxmisc, edev_ctl);
> +               else
> +                       edac_printk(KERN_ERR, DRV_NAME, "Unknown error\n");
> +               break;
> +       default:
> +               edac_printk(KERN_ERR, DRV_NAME, "Unknown level\n");
> +       }
> +}
> +
> +static inline void kryo_clear_error(u64 errxstatus)
> +{
> +       write_sysreg_s(errxstatus, SYS_ERXSTATUS_EL1);
> +       isb();

Is the isb() necessary? If so, why not a dsb as well?

> +}
> +
> +static void kryo_parse_l1_l2_cache_error(u64 errxstatus, u64 errxmisc,
> +                                        struct edac_device_ctl_info *edev_ctl,
> +                                        int cpu)
> +{
> +       u32 part_num = read_cpuid_part_number();
> +
> +       switch (part_num) {
> +       /* Kryo3XX gold CPU cores do not have a UNIT bitfield */
> +       case KRYO3XX_GOLD:
> +       case KRYO4XX_SILVER_V1:
> +       case KRYO4XX_SILVER_V2:
> +               switch (FIELD_GET(KRYO_ERRXMISC0_LVL, errxmisc)) {
> +               case KRYO_L1:
> +                       kryo_check_err_type(errxstatus, errxmisc,
> +                                           edev_ctl, KRYO_L1);
> +                       break;
> +               case KRYO_L2:
> +                       kryo_check_err_type(errxstatus, errxmisc,
> +                                           edev_ctl, KRYO_L2);
> +                       break;
> +               default:
> +                       edac_printk(KERN_ERR, DRV_NAME,
> +                                   "silver cpu:%d unknown error: %lu\n", cpu,
> +                                   FIELD_GET(KRYO_ERRXMISC0_LVL, errxmisc));
> +               }
> +               break;
> +       /* Kryo4XX gold CPU cores have a UNIT bitfield to identify levels */
> +       case KRYO4XX_GOLD:
> +               switch (FIELD_GET(KRYO_ERRXMISC0_UNIT, errxmisc)) {
> +               case KRYO_L1_UNIT_DC:
> +               case KRYO_L1_UNIT_IC:
> +                       kryo_check_err_type(errxstatus, errxmisc,
> +                                           edev_ctl, KRYO_L1);
> +                       break;
> +               case KRYO_L2_UNIT:
> +               case KRYO_L2_UNIT_TLB:
> +                       kryo_check_err_type(errxstatus, errxmisc,
> +                                           edev_ctl, KRYO_L2);
> +                       break;
> +               default:
> +                       edac_printk(KERN_ERR, DRV_NAME,
> +                                   "gold cpu:%d unknown error: %lu\n", cpu,
> +                                   FIELD_GET(KRYO_ERRXMISC0_UNIT, errxmisc));
> +               }
> +               break;
> +       default:
> +               edac_printk(KERN_ERR, DRV_NAME,
> +                           "Error in matching cpu%d with part num:%u\n",
> +                           cpu, part_num);
> +       }
> +}
> +
> +static inline bool kryo_check_regs_valid(u64 errxstatus)
> +{
> +       /* Check if status and misc regs are valid */
> +       if (!(FIELD_GET(KRYO_ERRXSTATUS_VALID, errxstatus)) ||
> +           !(FIELD_GET(KRYO_ERRXSTATUS_MV, errxstatus)))
> +               return false;
> +
> +       return true;
> +}
> +
> +static void kryo_check_l1_l2_ecc(void *info)
> +{
> +       struct edac_device_ctl_info *edev_ctl = info;
> +       u64 errxstatus;
> +       u64 errxmisc;
> +       int cpu;
> +
> +       cpu = smp_processor_id();
> +       /* We know record 0 is L1 and L2 */
> +       write_sysreg_s(0, SYS_ERRSELR_EL1);
> +       isb();

Another isb I'm not sure about. Is this meant to provide a barrier
between ERRSELR and ERXSTATUS? Wouldn't that be dsb, not isb?

> +
> +       errxstatus = read_sysreg_s(SYS_ERXSTATUS_EL1);
> +       if (!kryo_check_regs_valid(errxstatus))
> +               return;
> +
> +       errxmisc = read_sysreg_s(SYS_ERXMISC0_EL1);
> +       /* Check if L1/L2 error */
> +       if (!(FIELD_GET(KRYO_ERRXMISC0_LVL, errxmisc) == KRYO_L1) &&
> +           !(FIELD_GET(KRYO_ERRXMISC0_LVL, errxmisc) == KRYO_L2))
> +               return;
> +
> +       kryo_parse_l1_l2_cache_error(errxstatus, errxmisc, edev_ctl, cpu);
> +       kryo_clear_error(errxstatus);
> +}
> +
