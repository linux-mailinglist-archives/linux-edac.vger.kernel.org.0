Return-Path: <linux-edac+bounces-5788-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFAsFm3LrmnEIwIAu9opvQ
	(envelope-from <linux-edac+bounces-5788-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Mon, 09 Mar 2026 14:30:21 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8738239C2F
	for <lists+linux-edac@lfdr.de>; Mon, 09 Mar 2026 14:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AC543057EBB
	for <lists+linux-edac@lfdr.de>; Mon,  9 Mar 2026 13:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBC93BFE5E;
	Mon,  9 Mar 2026 13:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FFD+a1v/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KeDmsxx+"
X-Original-To: linux-edac@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5743A3ACF11
	for <linux-edac@vger.kernel.org>; Mon,  9 Mar 2026 13:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773062927; cv=none; b=jwvEvuxmDCpmXDbvfUgyAJMQj6WNwtpBfroDxJqZwPqY4jKbexuvKJ9nyruLIKC1RmtMxeI0e/dCtAOhJItXbqO/G6gpQPfJMh5eRb6uWetuMI6COso5zJFc5yvvLFGbl9LN0VuSIhkHYDv/Y0oF5ZIbOEjNraAYCavYLARyGkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773062927; c=relaxed/simple;
	bh=jIr9e+Rhmr3XjUEnPVgpCtQXQAFbSJyH+evMq47zWrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WZkN7mBGG5VddKQeCzSjye0Kz2t0UcVgmG4M3UJOvE5WvO1uLcDQgRTRb4QRaG7Q+URdcSM05r0exGsl8PcD6ZOvh4GbtjgsE30A0SySml4WzeidxfGc4JljMA8WTKZKuinRf13UVLtZfOWepfAY2r1HUbbH89CwK56FWr7iGlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FFD+a1v/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KeDmsxx+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6298WA903773176
	for <linux-edac@vger.kernel.org>; Mon, 9 Mar 2026 13:28:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fnfugPh5B+LbknIiKQszfyisSyvY3KjBZqNzEIMIThI=; b=FFD+a1v/aR3KoRdc
	Da2K/cGUixBiX2O9Xq4wA6Ke2vVqpLT97D6Hr0VJp1MHMTRGNVLc/t6Wfe3+J6E3
	iLuPef+qjEvTGklfkpDVlW5KHbhydyOd4rwbf7rPH2KlZzuG2+NolXCKcL8W8m7D
	1a2Da+Yk0nMmiwdLgTQ9+G46CV7VhCjp44JnK40gflSt0nuc2QowVq48oyJH3xCJ
	tnBrbebSmWJ48oRIg1rWmQJy9b8R9SS4rXXbv6iSSPLxPcuc4LxvesYnl23rRPI4
	kHDemytbuCYFUgwr8vQjrYOM99UifO1yBPnD5oOaYqB2uBVK6VF1CP2jOkrioo7O
	7YF76Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cstsa905h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-edac@vger.kernel.org>; Mon, 09 Mar 2026 13:28:42 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35988121f5eso4491712a91.1
        for <linux-edac@vger.kernel.org>; Mon, 09 Mar 2026 06:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773062921; x=1773667721; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fnfugPh5B+LbknIiKQszfyisSyvY3KjBZqNzEIMIThI=;
        b=KeDmsxx+dP5ZIZhWuwPYemC2b4o75/E0uovsRGP3/JqsxMW7K2M+HhimlQldMejtKr
         14o4iMbDmC7nyvDwbYEWEqsRsdzkY7/VqUqqMf0vmZl2JyjkLobR7kUHVpPsZ/Xq8UG3
         R28/g9ePYDTHFluElLt19/5amHpY0PjvPNIihvc/nO9W3IWcDY3OcuSKbAqwAj9leIxK
         Nz4NXNY33UzUjKDvvszB3xq2qNFSAUMRL2RdH8KsyemT7HAL5qqbROHM2bRRrXc0X8ka
         PV1fNCwWSTVxczxCgCvwkLhjmBArinlGPDtb3zUtxSzu53LljJ4rVgjEzaZXPrxWXXx/
         zG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773062921; x=1773667721;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fnfugPh5B+LbknIiKQszfyisSyvY3KjBZqNzEIMIThI=;
        b=R/GfDX30XjwLY6YplYRD6lB3/OIJ60E9EOdFNHrQm+7m31k4uaODDaO6NJURqrsE4b
         M+gZP0xlryzFGM6QSBo5JqadE+nI7lqkwGC+q/38cSkWmbFtScN1IXdWlmmtOb0hoX7I
         PZj6agb1YsZw5brKjCZP2V567znSbykQy0+88ySSvpt/IFK/hqC1SP3dnly3HFNA/Gif
         WjI3up153rh9Q5mlMeWK+1dJ8BxWT0AWfLoaBL0xev2X2oMJliHONBWf4KZSbbxgWN4u
         3oTnKTearyyn1RHSL0qtiMLp9rx4Zs+u5KM1CZXPCfdnApin1EYn9tlZbZrk5Vs7zjhZ
         9NRA==
X-Forwarded-Encrypted: i=1; AJvYcCVY376EdwTkzYawubP7tpd6MvLEoVgthJ+9gqy8MeJXtXfearfFK9QcTW/DX4UtW8YMJ8wzO6JI+9P5@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7FkZxzHsOJ69a8FGMDOX/egZ2v0HYkIkZ2lju6Wdu/IcjL/gn
	ssMN1UD5D99F8Ce1fycFV5LHkydwgGB688X9KQVF4Ysk10FkWwjklVOSyBH1RKvGLrml+noqlny
	NfgIR73Ev7om1X6qNRcUwpT/TcDR6K//QOpcvJKS9kHyF50FHX+oX0l8HUPv3gb5n
X-Gm-Gg: ATEYQzxmLVH+YvEibldvmJU14fjsMjG9VLn9VRcDmTt95RszHciqh5VO2OgBeLtg1f+
	AYSuR+3YMFZbz//QKcC4OsSlOmnZlOaZhAlIC+H49UthI1aqQ507e9QXTuxz91GWh3O6y+jkJAh
	5L4mQ3c3rqMAymBFoCJvcFHyDmAFzCIhXjsUjde8tyZR3IR9yz9ZkHKIeYGrZ+AxUzhqG3Vjbf8
	OHehPnlyh/wg4P3PbcY1M8Q0xhsBBMkh31ityvRY7GlS4TMb4e7an58VMe/s6Shg/fdPjDMSJxO
	1h5Kf10vA73h8HTo8Arga7eqhijoxjupZwrv0C3owKuecA3jaRRKZOg9zZvO8jZ5lPMCvzaVSfK
	gJGTg62Gm2m/xLo9pq8atbDDhxDWUQOgV//Mqo+fA3SvNgQUlxYodH6lKH9uPINtMnLrCd9ZOSj
	Kyb5+mrVTJ
X-Received: by 2002:a17:90a:fc45:b0:359:8d95:4a57 with SMTP id 98e67ed59e1d1-359be352188mr7707186a91.6.1773062920816;
        Mon, 09 Mar 2026 06:28:40 -0700 (PDT)
X-Received: by 2002:a17:90a:fc45:b0:359:8d95:4a57 with SMTP id 98e67ed59e1d1-359be352188mr7707158a91.6.1773062920025;
        Mon, 09 Mar 2026 06:28:40 -0700 (PDT)
Received: from ?IPV6:2406:b400:b5:b794:54ad:c739:c526:34f4? ([2406:b400:b5:b794:54ad:c739:c526:34f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359bc9bd61fsm5864869a91.3.2026.03.09.06.28.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 06:28:39 -0700 (PDT)
Message-ID: <edf7e7eb-8f02-4672-bc31-16e0a8fb9715@oss.qualcomm.com>
Date: Mon, 9 Mar 2026 18:58:29 +0530
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/16] Support Armv8 RAS Extensions for Kernel-first
 error handling
To: Ruidong Tian <tianruidong@linux.alibaba.com>, catalin.marinas@arm.com,
        will@kernel.org, lpieralisi@kernel.org, guohanjun@huawei.com,
        sudeep.holla@arm.com, rafael@kernel.org, robin.murphy@arm.com,
        mark.rutland@arm.com, tony.luck@intel.com, bp@alien8.de,
        tglx@linutronix.de, peterz@infradead.org
Cc: lenb@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-edac@vger.kernel.org,
        mchehab@kernel.org, xueshuai@linux.alibaba.com,
        zhuo.song@linux.alibaba.com, oliver.yang@linux.alibaba.com
References: <20260122094656.73399-1-tianruidong@linux.alibaba.com>
Content-Language: en-US
From: Umang Chheda <umang.chheda@oss.qualcomm.com>
In-Reply-To: <20260122094656.73399-1-tianruidong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: VUs474exi_uJmLG5O-RZyk0zspgghFks
X-Authority-Analysis: v=2.4 cv=I+Vohdgg c=1 sm=1 tr=0 ts=69aecb0a cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=7CQSdrXTAAAA:8
 a=VwQbUJbxAAAA:8 a=zd2uoN0lAAAA:8 a=vzhER2c_AAAA:8 a=SRrdq9N9AAAA:8
 a=NEAV23lmAAAA:8 a=QyXUC8HyAAAA:8 a=cpMiU1yUC2MWLmdqKLoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=0YTRHmU2iG2pZC6F1fw2:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEyMyBTYWx0ZWRfXy1+ikueS4Xt1
 aq//pKLEScWc9d20d1CQnVz1qh35wpge+N0DVzy8j1THb9YjqKVcV5BY8jbx8NmcLqpTu8SrSh5
 tqq3kVb2YlXpiPZ+IdxD4SLA/XfVAlr1OEItCCtSU1FpIvgkRnQPoZI9A/vNEsR/qTdwn4zjceW
 RG7u9Y8qTYjeTVx7fTLrtOs46LBcIP/BOxz7x2JVUeJAqrguUWheBgqVNraSs4RDq3J7JkAGCB8
 mbbJwjkOQrm8fhJ1d2NkwQmfmJkego4ikyCfyeSSqswoAxdRN37qnvjAoa8jqNry9C7gmqvyqbk
 T+TcgGUd1RUvr9JCElCj4Ac1Oj6Jr2P7HFi91KLq2L++RDfthEsStmqFetpTgx2qzgd5pGmuCyL
 MS4q/dorZ9PhKpAmJLyhgzAYRZtYLSjAoFzjBNC3slygAJ3YpDNAWbls2/9OH+nQbrzsFewDsz4
 aX+Sq7468k3ldWXraSA==
X-Proofpoint-ORIG-GUID: VUs474exi_uJmLG5O-RZyk0zspgghFks
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_03,2026-03-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1011 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090123
X-Rspamd-Queue-Id: A8738239C2F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-5788-lists,linux-edac=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,arm.com:url];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[umang.chheda@oss.qualcomm.com,linux-edac@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.954];
	TAGGED_RCPT(0.00)[linux-edac];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Hello Ruidong Tain,

On 1/22/2026 3:16 PM, Ruidong Tian wrote:
> Motivation: Reliability in Modern Data Centers
> =================================================
> In modern data centers, proactive maintenance is essential for achieving high
> service availability. The practice of using Corrected Errors (CE) to predict
> impending Uncorrected Errors (UE) is already widely deployed at scale across
> the industry, like Alibaba[2], Tencent[4], Intel[1], AMD[2]. By analyzing CE
> telemetry, operators can identify failing hardware and perform migrations
> before catastrophic failures occur.
>
> Problem: Inefficient CE Collection on ARM
> ==========================================
> Currently, ARM-based systems primarily rely on "Firmware-First" error
> handling (e.g., via GHES). This path is inherently heavy-weight. To avoid
> significant performance overhead, firmware is often configured with high
> thresholds—reporting to the OS only after thousands of CEs have occurred.
> If the threshold is set lower, the high frequency of errors leads to
> excessive and costly context switching between the OS and firmware.
> Consequently, ARM platforms currently lack an efficient mechanism to collect
> the granular CE data required for high-fidelity error prediction.
>
> Solution: Kernel-First Handling via AEST
> ===========================================
> Other architectures have long utilized "Kernel-First" approaches for
> efficient CE collection: Intel provides CMCI (Corrected Machine Check
> Interrupt), and AMD has recently introduced similar CE interrupt support[5].
>
> On the ARM architecture, hardware already provides the necessary RAS
> Extensions[6], and the ACPI AEST specification[0] defines a standardized way for
> the OS to discover these error source registers. This series implements
> AEST support, enabling the kernel to:
>
>  - Discover error sources directly via ACPI tables.
>  - Handle CE notifications via direct interrupts.
>  - Bypass firmware overhead to collect every CE or use low-latency thresholds.
>
> This implementation provides the missing link for efficient RAS telemetry
> on ARM, bringing it to parity with other enterprise architectures.

Thanks for posting this series enabling kernel-first handling for the Armv8 RAS extensions.

We noticed the current implementation targets ACPI-based server platforms. For embedded/SoC systems, Device Tree is often the primary firmware description. 
Do you have any plans to add DT-based support for the same flow? If not, do you see any blockers to extending this series to support DT 
(e.g., DT bindings + discovery/registration path analogous to the ACPI plumbing) ? 
If DT support is in-scope, We would be happy to align on the expected approach and help with review/development/testing for DT-based platforms.

> Background and Maintenance
> =============================
> This series is based on Tyler Baicar's preliminary patches [7]. I attempted
> to follow up with Tyler in 2022 [8] but received no reply. As he no longer
> appears active on the mailing list, I have picked up this work, updated it
> to align with the latest AEST v2.0 specification, and addressed pending
> feedback to ensure this critical feature is integrated into the mainline.
>
> AEST Driver Architecture
> ========================
>
> The AEST driver is structured into three primary components:
>   - AEST device: Responsible for handling interrupts, managing the lifecycle
>                  of AEST nodes, and processing error records.
>   - AEST node: Corresponds directly to a RAS node in the hardware
>   - AEST record: Represents a set of RAS registers associated with a specific
>                  error source.
>
> Comparison with x86 MCA:
>
> RAS record ≈ MCA bank.
> RAS node ≈ A set of MCA banks + CMCI on a core.
>
> The key difference lies in uncore handling: x86 typically maps uncore errors
> (like those from a memory controller) into core-based MCA banks. In contrast,
> ARM requires uncore components to provide their own standalone RAS nodes. When
> a component requires multiple such nodes, they are grouped and managed as a
> "RAS device" in AEST driver. 
>
> These components are organized hierarchically as follows:
>
>  ┌──────────────────────────────────────────────────┐
>  │             AEST Driver Device Management        │
>  │┌─────────────┐    ┌──────────┐     ┌───────────┐ │
>  ││ AEST Device ├─┬─►│AEST Node ├──┬─►│AEST Record│ │
>  │└─────────────┘ │  └──────────┘  │  └───────────┘ │
>  │                │       .        │  ┌───────────┐ │
>  │                │       .        ├─►│AEST Record│ │
>  │                │       .        │  └───────────┘ │
>  │                │  ┌──────────┐  │        .       │
>  │                ├─►│AEST Node │  │        .       │
>  │                │  └──────────┘  │        .       │
>  │                │                │  ┌───────────┐ │
>  │                │  ┌──────────┐  └─►│AEST Record│ │
>  │                └─►│AEST Node │     └───────────┘ │
>  │                   └──────────┘                   │
>  └──────────────────────────────────────────────────┘
>
> AEST Interrupt Handle
> =====================
>
> Upon an AEST interrupt, the driver performs the following sequence:
> 1. The AEST device iterates through all registered AEST nodes to identify the
>    specific node(s) and record(s) that reported an error.
> 2. Each node typically contains two types of records:
>       - report record: Errors can be located efficiently through a bitmap
>                        in the `ERRGSR` register.
>       - poll record: The node must individually poll all records to determine
>                      if an error has occurred.
> 3. process record:
>       - if error is corrected, The CE threshold is reset, and the error event
>         is logged.
>       - if error is defered, Relevant registers are dumped, and
>         `memory_failure()` is invoked.
>       - if error is uncorrected, panic, While UEs typically trigger an
>         exception rather than an interrupt, if detected, the system will panic.
> 4. decode record: The AEST driver notifies other relevant drivers, such as
>    EDAC, to further decode the reported RAS register information.
>
> Testing
> ===================
> I have tested this series on THead Yitian710 SOC with customized BIOS. Someone
> can also use QEMU[9] for preliminary driver testing.
>
> 1. Boot Qemu
>
> qemu-system-aarch64 -smp 4 -m 32G \
>   -cpu host --enable-kvm -machine virt,gic-version=3 \
>   -kernel Image -initrd initrd.cpio.gz \
>   -device virtio-net-pci,netdev=t0 -netdev user,id=t0 \
>   -bios /usr/share/edk2/aarch64/QEMU_EFI.fd  \
>   -append "rdinit=/sbin/init earlycon verbose debug console=ttyAMA0 aest.dyndbg='+pt'" \
>   -nographic -d guest_errors -D qemu.log
>
> 2. inject error
> devmem 0x90d0808 l 0xc4800390
>
> 2.1 Memory error
> [   64.959849] AEST: {1}[Hardware Error]: Hardware error from AEST memory.90d0000
> [   64.959852] AEST: {1}[Hardware Error]:  Error from memory at SRAT proximity domain 0x0
> [   64.959855] AEST: {1}[Hardware Error]:   ERR0FR: 0x40000080044081
> [   64.959858] AEST: {1}[Hardware Error]:   ERR0CTRL: 0x108
> [   64.959859] AEST: {1}[Hardware Error]:   ERR0STATUS: 0xc4800390
> [   64.959860] AEST: {1}[Hardware Error]:   ERR0ADDR: 0x8400000043344521
> [   64.959861] AEST: {1}[Hardware Error]:   ERR0MISC0: 0x7fff00000000
> [   64.959861] AEST: {1}[Hardware Error]:   ERR0MISC1: 0x0
> [   64.959862] AEST: {1}[Hardware Error]:   ERR0MISC2: 0x0
> [   64.959863] AEST: {1}[Hardware Error]:   ERR0MISC3: 0x0
> [   64.959873] Memory failure: 0x43344: recovery action for free buddy page: Recovered
>
> 2.2 CMN error
> [  132.044283] AEST: {2}[Hardware Error]: Hardware error from AEST XP
> [  132.044286] AEST: {2}[Hardware Error]:  Error from vendor hid ARMHC700 uid 0x0
> [  132.044288] AEST: {2}[Hardware Error]:   ERR0FR: 0x48a5
> [  132.044290] AEST: {2}[Hardware Error]:   ERR0CTRL: 0x108
> [  132.044292] AEST: {2}[Hardware Error]:   ERR0STATUS: 0xc4800390
> [  132.044293] AEST: {2}[Hardware Error]:   ERR0ADDR: 0x8400000043344521
> [  132.044295] AEST: {2}[Hardware Error]:   ERR0MISC0: 0x0
> [  132.044296] AEST: {2}[Hardware Error]:   ERR0MISC1: 0x0
> [  132.044298] AEST: {2}[Hardware Error]:   ERR0MISC2: 0x0
> [  132.044299] AEST: {2}[Hardware Error]:   ERR0MISC3: 0x0
> [  132.044302] Memory failure: 0x43344: recovery action for already poisoned page: Failed
>
> [0]: https://developer.arm.com/documentation/den0085/0200/
> [1]: Intel: Predicting Uncorrectable Memory Errors from the Correctable Error History
> [2]: Alibaba. Predicting DRAM-Caused Risky VMs in Large-Scale Clouds. Published in HPCA2025
> [3]: AMD: Physics-informed machinelearning for dram error modeling
> [4]: Tencent: Predicting uncorrectablememory errors for proactive replacement: An empirical study on large-scale field data
> [5]: https://lore.kernel.org/all/20251104-wip-mca-updates-v8-4-66c8eacf67b9@amd.com/
> [6]: https://developer.arm.com/documentation/ihi0100/
> [7]: https://lore.kernel.org/all/20211124170708.3874-1-baicar@os.amperecomputing.com/
> [8]: https://lore.kernel.org/all/b365db02-b28c-1b22-2e87-c011cef848e2@linux.alibaba.com/
> [9]: https://github.com/winterddd/qemu/tree/error_record
>
> Change from V5:
> https://lore.kernel.org/all/20251230090945.43969-1-tianruidong@linux.alibaba.com/
> 1. Based on the feedback from Borislav Petkov, I've dropped the idea of a 
>    unified address translation interface across ARM and AMD.
>
> Change from V4:
> https://lore.kernel.org/all/20251222094351.38792-1-tianruidong@linux.alibaba.com/
> 1. Fix build warning in 0010 and 0014 report by kernel test robot:
>     https://lore.kernel.org/all/202512230122.CfXZcF76-lkp@intel.com/
>     https://lore.kernel.org/all/202512230007.Vs6IvFVD-lkp@intel.com/
> 2. Dropped the extra patch(0014) that was mistakenly included in v4.
>
> Change from V3:
> https://lore.kernel.org/all/20250115084228.107573-1-tianruidong@linux.alibaba.com/
> 1. Add vendor AEST node framework and support CMN700
> 2. Borislav Petkov
>     - Split into multiple smaller patches for easier review.
>     - refined the English in the cover letter for better flow.
> 3. Accept Tomohiro Misono's comment
>
> Change from V2:
> https://lore.kernel.org/all/20240321025317.114621-1-tianruidong@linux.alibaba.com/
> 1. Tomohiro Misono
>     - dump register before panic
> 2. Baolin Wang & Shuai Xue: accept all comment.
> 3. Support AEST V2.
>
> Change from V1:
> https://lore.kernel.org/all/20240304111517.33001-1-tianruidong@linux.alibaba.com/
> 1. Marc Zyngier
>   - Use readq/writeq_relaxed instead of readq/writeq for MMIO address.
>   - Add sync for system register operation.
>   - Use irq_is_percpu_devid() helper to identify a per-CPU interrupt.
>   - Other fix.
> 2. Set RAS CE threshold in AEST driver.
> 3. Enable RAS interrupt explicitly in driver.
> 4. UER and UEO trigger memory_failure other than panic.
>
> Ruidong Tian (16):
>   ACPI/AEST: Parse the AEST table
>   ras: AEST: Add probe/remove for AEST driver
>   ras: AEST: support different group format
>   ras: AEST: Unify the read/write interface for system and MMIO register
>   ras: AEST: Probe RAS system architecture version
>   ras: AEST: Support RAS Common Fault Injection Model Extension
>   ras: AEST: Support CE threshold of error record
>   ras: AEST: Enable and register IRQs
>   ras: AEST: Add cpuhp callback
>   ras: AEST: Introduce AEST driver sysfs interface
>   ras: AEST: Add error count tracking and debugfs interface
>   ras: AEST: Allow configuring CE threshold via debugfs
>   ras: AEST: Introduce AEST inject interface to test AEST driver
>   ras: AEST: Add framework to process AEST vendor node
>   ras: AEST: support vendor node CMN700
>   trace, ras: add ARM RAS extension trace event
>
>  Documentation/ABI/testing/debugfs-aest |   99 +++
>  MAINTAINERS                            |   11 +
>  arch/arm64/include/asm/arm-cmn.h       |   47 ++
>  arch/arm64/include/asm/ras.h           |   95 +++
>  drivers/acpi/arm64/Kconfig             |   11 +
>  drivers/acpi/arm64/Makefile            |    1 +
>  drivers/acpi/arm64/aest.c              |  311 +++++++
>  drivers/perf/arm-cmn.c                 |   37 +-
>  drivers/ras/Kconfig                    |    1 +
>  drivers/ras/Makefile                   |    1 +
>  drivers/ras/aest/Kconfig               |   17 +
>  drivers/ras/aest/Makefile              |    8 +
>  drivers/ras/aest/aest-cmn.c            |  330 ++++++++
>  drivers/ras/aest/aest-core.c           | 1054 ++++++++++++++++++++++++
>  drivers/ras/aest/aest-inject.c         |  131 +++
>  drivers/ras/aest/aest-sysfs.c          |  228 +++++
>  drivers/ras/aest/aest.h                |  410 +++++++++
>  drivers/ras/ras.c                      |    3 +
>  include/linux/acpi_aest.h              |   75 ++
>  include/linux/cpuhotplug.h             |    1 +
>  include/linux/ras.h                    |    8 +
>  include/ras/ras_event.h                |   71 ++
>  22 files changed, 2914 insertions(+), 36 deletions(-)
>  create mode 100644 Documentation/ABI/testing/debugfs-aest
>  create mode 100644 arch/arm64/include/asm/arm-cmn.h
>  create mode 100644 arch/arm64/include/asm/ras.h
>  create mode 100644 drivers/acpi/arm64/aest.c
>  create mode 100644 drivers/ras/aest/Kconfig
>  create mode 100644 drivers/ras/aest/Makefile
>  create mode 100644 drivers/ras/aest/aest-cmn.c
>  create mode 100644 drivers/ras/aest/aest-core.c
>  create mode 100644 drivers/ras/aest/aest-inject.c
>  create mode 100644 drivers/ras/aest/aest-sysfs.c
>  create mode 100644 drivers/ras/aest/aest.h
>  create mode 100644 include/linux/acpi_aest.h


Thanks,
Umang


