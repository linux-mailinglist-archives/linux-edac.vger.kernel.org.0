Return-Path: <linux-edac+bounces-4121-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC70DAD783A
	for <lists+linux-edac@lfdr.de>; Thu, 12 Jun 2025 18:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FDCC172266
	for <lists+linux-edac@lfdr.de>; Thu, 12 Jun 2025 16:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF1E29A331;
	Thu, 12 Jun 2025 16:29:57 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01A8221DA8;
	Thu, 12 Jun 2025 16:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749745797; cv=none; b=RBpxPxbnp7saPzs2Hp+3wDwx+onYoP+mabziPi1vNPEtPZMoEivz1+U48J76+VpugHZjg1Gg+kV7sOED+tVqV5qOsPIJ1QugvjNWQaKdF8SpbN+MaV/je+CEaHZtx9S421mQ4uVGZdOIWVFJXj5HWu6j7th3MNPC6h3qFeTwd+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749745797; c=relaxed/simple;
	bh=phu4Pf2U1PUE+ihJr093ki7ZpYmL1li+dZfsL6BgNmQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V7YFveji6LkXYCh2iYN39K41jB/yDLmaykaIoqCWwyCHrXL+3tBln0mAmFRu+m55RrvuveJki1z12vb8+/OPh4Tb6vfomj9GTtMDbTkbY6bzE3/5xFE1/9nlu2AHPfM5Gu+ovApoq/ZkKKIEB5bhgDVqvmxo8saWgkmC2IUWL08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bJ7K10QqWz6M522;
	Fri, 13 Jun 2025 00:29:25 +0800 (CST)
Received: from frapeml500006.china.huawei.com (unknown [7.182.85.219])
	by mail.maildlp.com (Postfix) with ESMTPS id 11FE314010C;
	Fri, 13 Jun 2025 00:29:51 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500006.china.huawei.com (7.182.85.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Jun 2025 18:29:50 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Thu, 12 Jun 2025 18:29:50 +0200
From: Shiju Jose <shiju.jose@huawei.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>
CC: "rafael@kernel.org" <rafael@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "lenb@kernel.org"
	<lenb@kernel.org>, "leo.duran@amd.com" <leo.duran@amd.com>,
	"mchehab@kernel.org" <mchehab@kernel.org>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	Linuxarm <linuxarm@huawei.com>, "rientjes@google.com" <rientjes@google.com>,
	"jiaqiyan@google.com" <jiaqiyan@google.com>, "Jon.Grimm@amd.com"
	<Jon.Grimm@amd.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "naoya.horiguchi@nec.com"
	<naoya.horiguchi@nec.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "somasundaram.a@hpe.com"
	<somasundaram.a@hpe.com>, "erdemaktas@google.com" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>, "duenwen@google.com"
	<duenwen@google.com>, "gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>, "Roberto
 Sassu" <roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
	<kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>
Subject: RE: [PATCH v8 1/2] ACPI:RAS2: Add ACPI RAS2 driver
Thread-Topic: [PATCH v8 1/2] ACPI:RAS2: Add ACPI RAS2 driver
Thread-Index: AQHb2gR3tWHm7iz+OUiWD23bPHqjMrP+MPIAgAE1DUA=
Date: Thu, 12 Jun 2025 16:29:50 +0000
Message-ID: <3fe6a12393f34bf5870313b59fa39e11@huawei.com>
References: <20250610123725.1652-1-shiju.jose@huawei.com>
 <20250610123725.1652-2-shiju.jose@huawei.com>
 <20250611190136.GB288240@yaz-khff2.amd.com>
In-Reply-To: <20250611190136.GB288240@yaz-khff2.amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

>-----Original Message-----
>From: Yazen Ghannam <yazen.ghannam@amd.com>
>Sent: 11 June 2025 20:02
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: rafael@kernel.org; linux-edac@vger.kernel.org; linux-acpi@vger.kernel.=
org;
>linux-doc@vger.kernel.org; bp@alien8.de; tony.luck@intel.com;
>lenb@kernel.org; leo.duran@amd.com; mchehab@kernel.org; Jonathan
>Cameron <jonathan.cameron@huawei.com>; linux-mm@kvack.org; Linuxarm
><linuxarm@huawei.com>; rientjes@google.com; jiaqiyan@google.com;
>Jon.Grimm@amd.com; dave.hansen@linux.intel.com;
>naoya.horiguchi@nec.com; james.morse@arm.com; jthoughton@google.com;
>somasundaram.a@hpe.com; erdemaktas@google.com; pgonda@google.com;
>duenwen@google.com; gthelen@google.com;
>wschwartz@amperecomputing.com; dferguson@amperecomputing.com;
>wbs@os.amperecomputing.com; nifan.cxl@gmail.com; tanxiaofei
><tanxiaofei@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>; Roberto
>Sassu <roberto.sassu@huawei.com>; kangkang.shen@futurewei.com;
>wanghuiqiang <wanghuiqiang@huawei.com>
>Subject: Re: [PATCH v8 1/2] ACPI:RAS2: Add ACPI RAS2 driver
>
>On Tue, Jun 10, 2025 at 01:37:23PM +0100, shiju.jose@huawei.com wrote:
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> Add support for ACPI RAS2 feature table (RAS2) defined in the ACPI 6.5
>> Specification, section 5.2.21.
>> Driver defines RAS2 Init, which extracts the RAS2 table and driver
>> adds auxiliary device for each memory feature which binds to the
>> RAS2 memory driver.
>>
>> Driver uses PCC mailbox to communicate with the ACPI HW and the driver
>> adds OSPM interfaces to send RAS2 commands.
>>
>> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Co-developed-by: A Somasundaram <somasundaram.a@hpe.com>
>> Signed-off-by: A Somasundaram <somasundaram.a@hpe.com>
>> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Tested-by: Daniel Ferguson <danielf@os.amperecomputing.com>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>> ---
>>  drivers/acpi/Kconfig  |  11 ++
>>  drivers/acpi/Makefile |   1 +
>>  drivers/acpi/bus.c    |   3 +
>>  drivers/acpi/ras2.c   | 450 ++++++++++++++++++++++++++++++++++++++++++
>>  include/acpi/ras2.h   |  54 +++++
>>  5 files changed, 519 insertions(+)
>>  create mode 100644 drivers/acpi/ras2.c  create mode 100644
>> include/acpi/ras2.h
>>
>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig index
>> 7bc40c2735ac..846b27b49024 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -293,6 +293,17 @@ config ACPI_CPPC_LIB
>>  	  If your platform does not support CPPC in firmware,
>>  	  leave this option disabled.
>>
>> +config ACPI_RAS2
>> +	bool "ACPI RAS2 driver"
>> +	select AUXILIARY_BUS
>> +	select MAILBOX
>> +	select PCC
>> +	help
>> +	  The driver adds support for ACPI RAS2 feature table(extracts RAS2
>> +	  table from OS system table) and OSPM interfaces to send RAS2
>> +	  commands via PCC mailbox subspace. Driver adds platform device for
>> +	  the RAS2 memory features which binds to the RAS2 memory driver.
>> +
>>  config ACPI_PROCESSOR
>>  	tristate "Processor"
>>  	depends on X86 || ARM64 || LOONGARCH || RISCV diff --git
>> a/drivers/acpi/Makefile b/drivers/acpi/Makefile index
>> d1b0affb844f..abfec6745724 100644
>> --- a/drivers/acpi/Makefile
>> +++ b/drivers/acpi/Makefile
>> @@ -105,6 +105,7 @@ obj-$(CONFIG_ACPI_EC_DEBUGFS)	+=3D ec_sys.o
>>  obj-$(CONFIG_ACPI_BGRT)		+=3D bgrt.o
>>  obj-$(CONFIG_ACPI_CPPC_LIB)	+=3D cppc_acpi.o
>>  obj-$(CONFIG_ACPI_SPCR_TABLE)	+=3D spcr.o
>> +obj-$(CONFIG_ACPI_RAS2)		+=3D ras2.o
>>  obj-$(CONFIG_ACPI_DEBUGGER_USER) +=3D acpi_dbg.o
>>  obj-$(CONFIG_ACPI_PPTT) 	+=3D pptt.o
>>  obj-$(CONFIG_ACPI_PFRUT)	+=3D pfr_update.o pfr_telemetry.o
>> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c index
>> c2ab2783303f..5b4f04a4611c 100644
>> --- a/drivers/acpi/bus.c
>> +++ b/drivers/acpi/bus.c
>> @@ -31,6 +31,7 @@
>>  #include <acpi/apei.h>
>>  #include <linux/suspend.h>
>>  #include <linux/prmt.h>
>> +#include <acpi/ras2.h>
>>
>>  #include "internal.h"
>>
>> @@ -1474,6 +1475,8 @@ static int __init acpi_init(void)
>>  	acpi_debugger_init();
>>  	acpi_setup_sb_notify_handler();
>>  	acpi_viot_init();
>> +	acpi_ras2_init();
>> +
>>  	return 0;
>>  }
>>
>> diff --git a/drivers/acpi/ras2.c b/drivers/acpi/ras2.c new file mode
>> 100644 index 000000000000..97ca3feac2fe
>> --- /dev/null
>> +++ b/drivers/acpi/ras2.c
>> @@ -0,0 +1,450 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Implementation of ACPI RAS2 driver.
>> + *
>> + * Copyright (c) 2024-2025 HiSilicon Limited.
>> + *
>> + * Support for RAS2 - ACPI 6.5 Specification, section 5.2.21
>> + *
>> + * Driver contains ACPI RAS2 init, which extracts the ACPI RAS2 table
>> +and
>> + * get the PCC channel subspace for communicating with the ACPI
>> +compliant
>> + * HW platform which supports ACPI RAS2. Driver adds auxiliary
>> +devices
>> + * for each RAS2 memory feature which binds to the memory ACPI RAS2
>driver.
>> + */
>> +
>> +#define pr_fmt(fmt) "ACPI RAS2: " fmt
>> +
>> +#include <linux/delay.h>
>> +#include <linux/export.h>
>> +#include <linux/iopoll.h>
>> +#include <linux/ktime.h>
>> +#include <acpi/pcc.h>
>> +#include <acpi/ras2.h>
>> +
>> +static struct acpi_table_ras2 *__read_mostly ras2_tab;
>> +
>> +/**
>> + * struct ras2_pcc_subspace - Data structure for PCC communication
>> + * @mbox_client:	struct mbox_client object
>> + * @pcc_chan:		Pointer to struct pcc_mbox_chan
>> + * @comm_addr:		Pointer to RAS2 PCC shared memory region
>> + * @elem:		List for registered RAS2 PCC channel subspaces
>> + * @pcc_lock:		PCC lock to provide mutually exclusive access
>> + *			to PCC channel subspace
>> + * @deadline_us:	Poll PCC status register timeout in micro secs
>> + *			for PCC command complete
>> + * @pcc_mpar:		Maximum Periodic Access Rate(MPAR) for PCC
>channel
>> + * @pcc_mrtt:		Minimum Request Turnaround Time(MRTT) in
>micro secs
>> + *			OS must wait after completion of a PCC command
>before
>> + *			issue next command
>> + * @last_cmd_cmpl_time:	completion time of last PCC command
>> + * @last_mpar_reset:	Time of last MPAR count reset.
>> + * @mpar_count:		MPAR count
>> + * @pcc_id:		Identifier of the RAS2 platform communication channel
>> + * @pcc_chnl_acq:	Status of PCC channel acquired.
>> + * @kref:		kref object
>> + */
>> +struct ras2_pcc_subspace {
>> +	struct mbox_client		mbox_client;
>> +	struct pcc_mbox_chan		*pcc_chan;
>> +	struct acpi_ras2_shmem __iomem	*comm_addr;
>> +	struct list_head		elem;
>> +	struct mutex			pcc_lock;
>> +	unsigned int			deadline_us;
>> +	unsigned int			pcc_mpar;
>> +	unsigned int			pcc_mrtt;
>> +	ktime_t				last_cmd_cmpl_time;
>> +	ktime_t				last_mpar_reset;
>> +	int				mpar_count;
>> +	int				pcc_id;
>> +	bool				pcc_chnl_acq;
>> +	struct kref			kref;
>> +};
>> +
>> +/*
>> + * Arbitrary retries for PCC commands because the remote processor
>> + * could be much slower to reply. Keeping it high enough to cover
>> + * emulators where the processors run painfully slow.
>> + */
>> +#define RAS2_NUM_RETRIES 600ULL
>> +
>> +#define RAS2_FEAT_TYPE_MEMORY 0x00
>> +
>> +/* Static variables for the RAS2 PCC subspaces */ static
>> +DEFINE_MUTEX(ras2_pcc_list_lock);
>> +static LIST_HEAD(ras2_pcc_subspaces);
>> +
>> +static int ras2_report_cap_error(u32 cap_status) {
>> +	switch (cap_status) {
>> +	case ACPI_RAS2_NOT_VALID:
>> +	case ACPI_RAS2_NOT_SUPPORTED:
>> +		return -EPERM;
>> +	case ACPI_RAS2_BUSY:
>> +		return -EBUSY;
>> +	case ACPI_RAS2_FAILED:
>> +	case ACPI_RAS2_ABORTED:
>> +	case ACPI_RAS2_INVALID_DATA:
>> +		return -EINVAL;
>> +	default: /* 0 or other, Success */
>> +		return 0;
>> +	}
>> +}
>> +
>> +static int ras2_check_pcc_chan(struct ras2_pcc_subspace
>> +*pcc_subspace) {
>> +	struct acpi_ras2_shmem __iomem *gen_comm_base =3D pcc_subspace-
>>comm_addr;
>> +	u32 cap_status;
>> +	u16 status;
>> +	u32 rc;
>
>The u32 variables can be on the same line.

Hi Yazen,

Thanks for the comments.

Will do.
>
>> +
>> +	/*
>> +	 * As per ACPI spec, the PCC space will be initialized by
>> +	 * platform and should have set the command completion bit when
>> +	 * PCC can be used by OSPM.
>> +	 *
>> +	 * Poll PCC status register every 3us(delay_us) for maximum of
>> +	 * deadline_us(timeout_us) until PCC command complete bit is
>set(cond).
>> +	 */
>> +	rc =3D readw_relaxed_poll_timeout(&gen_comm_base->status, status,
>> +					status &
>PCC_STATUS_CMD_COMPLETE, 3,
>> +					pcc_subspace->deadline_us);
>> +	if (rc) {
>> +		pr_warn("PCC check channel failed for : %d rc=3D%d\n",
>
>The first "%d" will look like just a random number to the user. So the mes=
sage
>should include something like "pcc_id %d".
>
>Also, the only failure here (I think) would be a timeout. So the message c=
ould
>state that explicitly.
Will do.

>
>> +			pcc_subspace->pcc_id, rc);
>> +		return rc;
>> +	}
>> +
>> +	if (status & PCC_STATUS_ERROR) {
>
>The spec says
>"If set, an error occurred executing the last command."
>
>So this sounds like a feedback for the last command rather than indicating=
 a
>communication channel error.
>
>Maybe the PCC driver can save the "last command", and then this error
>condition can have a message to the user.
Will check and change.

>
>> +		status &=3D ~PCC_STATUS_ERROR;
>> +		writew_relaxed(status, &gen_comm_base->status);
>> +		return -EIO;
>> +	}
>> +
>> +	if (!(status & PCC_STATUS_CMD_COMPLETE))
>> +		return -EIO;
>
>This condition is impossible. Either this bit is set or we timed out earli=
er.
Ok. Will remove.

>
>> +
>> +	cap_status =3D readw_relaxed(&gen_comm_base->set_caps_status);
>> +	writew_relaxed(0x0, &gen_comm_base->set_caps_status);
>> +	return ras2_report_cap_error(cap_status);
>> +}
>> +
>> +/**
>> + * ras2_send_pcc_cmd() - Send RAS2 command via PCC channel
>> + * @ras2_ctx:	pointer to the RAS2 context structure
>> + * @cmd:	command to send
>> + *
>> + * Returns: 0 on success, an error otherwise  */ int
>> +ras2_send_pcc_cmd(struct ras2_mem_ctx *ras2_ctx, u16 cmd) {
>> +	struct ras2_pcc_subspace *pcc_subspace =3D ras2_ctx->pcc_subspace;
>> +	struct acpi_ras2_shmem __iomem *gen_comm_base =3D pcc_subspace-
>>comm_addr;
>> +	struct mbox_chan *pcc_channel;
>> +	unsigned int time_delta;
>> +	int rc;
>> +
>> +	rc =3D ras2_check_pcc_chan(pcc_subspace);
>> +	if (rc < 0)
>> +		return rc;
>> +
>> +	pcc_channel =3D pcc_subspace->pcc_chan->mchan;
>> +
>> +	/*
>> +	 * Handle the Minimum Request Turnaround Time(MRTT).
>> +	 * "The minimum amount of time that OSPM must wait after the
>completion
>> +	 * of a command before issuing the next command, in microseconds."
>> +	 */
>> +	if (pcc_subspace->pcc_mrtt) {
>> +		time_delta =3D ktime_us_delta(ktime_get(),
>> +					    pcc_subspace-
>>last_cmd_cmpl_time);
>> +		if (pcc_subspace->pcc_mrtt > time_delta)
>> +			udelay(pcc_subspace->pcc_mrtt - time_delta);
>> +	}
>> +
>> +	/*
>> +	 * Handle the non-zero Maximum Periodic Access Rate(MPAR).
>> +	 * "The maximum number of periodic requests that the subspace
>channel can
>> +	 * support, reported in commands per minute. 0 indicates no limitation=
."
>> +	 *
>> +	 * This parameter should be ideally zero or large enough so that it ca=
n
>> +	 * handle maximum number of requests that all the cores in the system
>can
>> +	 * collectively generate. If it is not, we will follow the spec and ju=
st
>> +	 * not send the request to the platform after hitting the MPAR limit i=
n
>> +	 * any 60s window.
>> +	 */
>> +	if (pcc_subspace->pcc_mpar) {
>> +		if (pcc_subspace->mpar_count =3D=3D 0) {
>> +			time_delta =3D ktime_ms_delta(ktime_get(),
>> +						    pcc_subspace-
>>last_mpar_reset);
>> +			if (time_delta < 60 * MSEC_PER_SEC) {
>> +				dev_dbg(ras2_ctx->dev,
>> +					"PCC cmd not sent due to MPAR limit");
>> +				return -EIO;
>> +			}
>> +			pcc_subspace->last_mpar_reset =3D ktime_get();
>> +			pcc_subspace->mpar_count =3D pcc_subspace-
>>pcc_mpar;
>> +		}
>> +		pcc_subspace->mpar_count--;
>> +	}
>> +
>> +	/* Write to the shared comm region */
>> +	writew_relaxed(cmd, &gen_comm_base->command);
>> +
>> +	/* Flip CMD COMPLETE bit */
>> +	writew_relaxed(0, &gen_comm_base->status);
>> +
>> +	/* Ring doorbell */
>> +	rc =3D mbox_send_message(pcc_channel, &cmd);
>> +	if (rc < 0) {
>> +		dev_warn(ras2_ctx->dev,
>> +			 "Err sending PCC mbox message. cmd:%d, rc:%d\n",
>cmd, rc);
>> +		return rc;
>> +	}
>> +
>> +	/*
>> +	 * If Minimum Request Turnaround Time is non-zero, we need
>> +	 * to record the completion time of both READ and WRITE
>> +	 * command for proper handling of MRTT, so we need to check
>> +	 * for pcc_mrtt in addition to CMD_READ.
>> +	 */
>> +	if (cmd =3D=3D PCC_CMD_EXEC_RAS2 || pcc_subspace->pcc_mrtt) {
>> +		rc =3D ras2_check_pcc_chan(pcc_subspace);
>> +		if (pcc_subspace->pcc_mrtt)
>> +			pcc_subspace->last_cmd_cmpl_time =3D ktime_get();
>> +	}
>> +
>> +	if (pcc_channel->mbox->txdone_irq)
>> +		mbox_chan_txdone(pcc_channel, rc);
>> +	else
>> +		mbox_client_txdone(pcc_channel, rc);
>> +
>> +	return rc >=3D 0 ? 0 : rc;
>> +}
>> +EXPORT_SYMBOL_GPL(ras2_send_pcc_cmd);
>> +
>> +static void ras2_list_pcc_release(struct kref *kref) {
>> +	struct ras2_pcc_subspace *pcc_subspace =3D
>> +		container_of(kref, struct ras2_pcc_subspace, kref);
>> +
>> +	guard(mutex)(&ras2_pcc_list_lock);
>> +	list_del(&pcc_subspace->elem);
>> +	pcc_mbox_free_channel(pcc_subspace->pcc_chan);
>> +	kfree(pcc_subspace);
>> +}
>> +
>> +static void ras2_pcc_get(struct ras2_pcc_subspace *pcc_subspace) {
>> +	kref_get(&pcc_subspace->kref);
>> +}
>> +
>> +static void ras2_pcc_put(struct ras2_pcc_subspace *pcc_subspace) {
>> +	kref_put(&pcc_subspace->kref,  &ras2_list_pcc_release); }
>> +
>> +static struct ras2_pcc_subspace *ras2_get_pcc_subspace(int pcc_id) {
>> +	struct ras2_pcc_subspace *pcc_subspace;
>> +
>> +	mutex_lock(&ras2_pcc_list_lock);
>
>Use "guard" here?
Sure.

>
>> +	list_for_each_entry(pcc_subspace, &ras2_pcc_subspaces, elem) {
>> +		if (pcc_subspace->pcc_id !=3D pcc_id)
>> +			continue;
>> +		ras2_pcc_get(pcc_subspace);
>> +		mutex_unlock(&ras2_pcc_list_lock);
>> +		return pcc_subspace;
>> +	}
>> +	mutex_unlock(&ras2_pcc_list_lock);
>> +
>> +	return NULL;
>> +}
>> +
>> +static int ras2_register_pcc_channel(struct ras2_mem_ctx *ras2_ctx,
>> +int pcc_id) {
>> +	struct ras2_pcc_subspace *pcc_subspace;
>> +	struct pcc_mbox_chan *pcc_chan;
>> +	struct mbox_client *mbox_cl;
>> +
>> +	if (pcc_id < 0)
>> +		return -EINVAL;
>> +
>> +	pcc_subspace =3D ras2_get_pcc_subspace(pcc_id);
>> +	if (pcc_subspace) {
>> +		ras2_ctx->pcc_subspace	=3D pcc_subspace;
>> +		ras2_ctx->comm_addr	=3D pcc_subspace->comm_addr;
>> +		ras2_ctx->dev		=3D pcc_subspace->pcc_chan->mchan-
>>mbox->dev;
>> +		ras2_ctx->pcc_lock	=3D &pcc_subspace->pcc_lock;
>> +		return 0;
>> +	}
>> +
>> +	pcc_subspace =3D kzalloc(sizeof(*pcc_subspace), GFP_KERNEL);
>> +	if (!pcc_subspace)
>> +		return -ENOMEM;
>> +
>> +	mbox_cl			=3D &pcc_subspace->mbox_client;
>> +	mbox_cl->knows_txdone	=3D true;
>> +
>> +	pcc_chan =3D pcc_mbox_request_channel(mbox_cl, pcc_id);
>> +	if (IS_ERR(pcc_chan)) {
>> +		kfree(pcc_subspace);
>> +		return PTR_ERR(pcc_chan);
>> +	}
>> +
>> +	pcc_subspace->pcc_id		=3D pcc_id;
>> +	pcc_subspace->pcc_chan		=3D pcc_chan;
>> +	pcc_subspace->comm_addr		=3D acpi_os_ioremap(pcc_chan-
>>shmem_base_addr,
>> +							  pcc_chan-
>>shmem_size);
>> +	pcc_subspace->deadline_us	=3D RAS2_NUM_RETRIES * pcc_chan-
>>latency;
>> +	pcc_subspace->pcc_mrtt		=3D pcc_chan-
>>min_turnaround_time;
>> +	pcc_subspace->pcc_mpar		=3D pcc_chan->max_access_rate;
>> +	pcc_subspace->mbox_client.knows_txdone	=3D true;
>> +	pcc_subspace->pcc_chnl_acq	=3D true;
>> +
>> +	kref_init(&pcc_subspace->kref);
>> +
>> +	mutex_lock(&ras2_pcc_list_lock);
>> +	list_add(&pcc_subspace->elem, &ras2_pcc_subspaces);
>> +	ras2_pcc_get(pcc_subspace);
>> +	mutex_unlock(&ras2_pcc_list_lock);
>> +
>> +	ras2_ctx->pcc_subspace	=3D pcc_subspace;
>> +	ras2_ctx->comm_addr	=3D pcc_subspace->comm_addr;
>> +	ras2_ctx->dev		=3D pcc_chan->mchan->mbox->dev;
>> +
>> +	mutex_init(&pcc_subspace->pcc_lock);
>> +	ras2_ctx->pcc_lock	=3D &pcc_subspace->pcc_lock;
>> +
>> +	return 0;
>> +}
>> +
>> +static DEFINE_IDA(ras2_ida);
>> +static void ras2_release(struct device *device) {
>> +	struct auxiliary_device *auxdev =3D container_of(device, struct
>auxiliary_device, dev);
>> +	struct ras2_mem_ctx *ras2_ctx =3D container_of(auxdev, struct
>> +ras2_mem_ctx, adev);
>> +
>> +	ida_free(&ras2_ida, auxdev->id);
>> +	ras2_pcc_put(ras2_ctx->pcc_subspace);
>> +	kfree(ras2_ctx);
>> +}
>> +
>> +static int ras2_add_aux_device(char *name, int channel) {
>> +	struct ras2_mem_ctx *ras2_ctx;
>> +	int id, rc;
>> +
>> +	ras2_ctx =3D kzalloc(sizeof(*ras2_ctx), GFP_KERNEL);
>> +	if (!ras2_ctx)
>> +		return -ENOMEM;
>> +
>> +	rc =3D ras2_register_pcc_channel(ras2_ctx, channel);
>> +	if (rc < 0) {
>> +		pr_debug("failed to register pcc channel rc=3D%d\n", rc);
>> +		goto ctx_free;
>> +	}
>> +
>> +	id =3D ida_alloc(&ras2_ida, GFP_KERNEL);
>> +	if (id < 0) {
>> +		rc =3D id;
>> +		goto pcc_free;
>> +	}
>> +
>> +	ras2_ctx->id			=3D id;
>> +	ras2_ctx->adev.id		=3D id;
>> +	ras2_ctx->adev.name		=3D RAS2_MEM_DEV_ID_NAME;
>> +	ras2_ctx->adev.dev.release	=3D ras2_release;
>> +	ras2_ctx->adev.dev.parent	=3D ras2_ctx->dev;
>> +
>> +	rc =3D auxiliary_device_init(&ras2_ctx->adev);
>> +	if (rc)
>> +		goto ida_free;
>> +
>> +	rc =3D auxiliary_device_add(&ras2_ctx->adev);
>> +	if (rc) {
>> +		auxiliary_device_uninit(&ras2_ctx->adev);
>> +		return rc;
>> +	}
>> +
>> +	return 0;
>> +
>> +ida_free:
>> +	ida_free(&ras2_ida, id);
>> +pcc_free:
>> +	ras2_pcc_put(ras2_ctx->pcc_subspace);
>> +ctx_free:
>> +	kfree(ras2_ctx);
>> +
>> +	return rc;
>> +}
>
>Just curious, would the new "faux" bus work for this use case?

I tried with "faux" interface, following are the observations.
1. RAS2 scrub control interface do present and work under /sys/bus/faux/dev=
ices/...
    as expected. However it does not appear under /sys/bus/edac/devices/...=
 as required.
   It seems that the reason for this is that, with the faux device, the RAS=
2 faux probe function=20
   and thus edac_dev_register() is called during the early boot stage, comp=
ared to the probe
    of the present auxiliary device based solution.=20
    I think EDAC is not fully initialized at that boot stage?
    This issue is solved with late_initcall(acpi_ras2_init) instead of call=
ing acpi_ras2_init()
    from  acpi_init() (drivers/acpi/bus.c).=20
  =20
2.  The faux_device_create() function takes a struct faux_device_ops *, whi=
ch requires the
      faux_device_ops for RAS2 to be defined within this driver (drivers/ac=
pi/ras2.c). Therefore,
      registration with EDAC for RAS features may necessitate moving to a *=
ras2_faux_probe()
       function here. This would also require moving the struct edac_scrub_=
ops ras2_scrub_ops and
        the corresponding callback functions from drivers/ras/acpi_ras2.c t=
o this location.
       Alternatively, we could add and export a ras2_faux_init() function i=
n drivers/ras/acpi_ras2.c
       and call it from *ras2_faux_probe().

Thus not sure  "faux" is a suitable interface for RAS2?

>

Thanks,
Shiju

