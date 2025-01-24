Return-Path: <linux-edac+bounces-2948-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF81A1BD0F
	for <lists+linux-edac@lfdr.de>; Fri, 24 Jan 2025 20:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E959B7A480A
	for <lists+linux-edac@lfdr.de>; Fri, 24 Jan 2025 19:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12612248BE;
	Fri, 24 Jan 2025 19:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="oMUfY5zD"
X-Original-To: linux-edac@vger.kernel.org
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C924D14A630;
	Fri, 24 Jan 2025 19:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737748583; cv=none; b=YMkSZfDGasXs+rS0sVp2uG/R8ydSle1kK308Amuq7SdAS132Scz10AHGMc8hO/jywjZ4DZPz2fH1/3qwt2LKJUHkiz6YrCczFFx16IDjZjbyo73uPteWrh2D5G5Cyh5zXo1fkgGmBSOdkXnSFGaijjyqqpoUFoG60SVeQ4W/NwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737748583; c=relaxed/simple;
	bh=JW6vHSyqoyC4rGHiXOyA4rjj7SGwGD0cWMuhMxpF0bs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rVBYQrZFgF5W4ML+4+oeZjjgmhHA3ZTkG1iVwD2Bd9MSS7VYPBSRkI0EmS4Oops8dAeUE6LNFXp2pM8pNxsLR1yJCSRSsbg0IYyIsgvXI38VU+Y/4bTuOEgpwxI9EOdURJX35L+YlVmt31NHqi0XDUNMdXW6d748VOJ7QTX8rvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=oMUfY5zD; arc=none smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0122331.ppops.net [127.0.0.1])
	by mx0b-00190b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OBUFKx003037;
	Fri, 24 Jan 2025 19:27:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=jan2016.eng;
	 bh=ydv8Gl8PE0n1jmHijJsb99eSzm8BxnGaIn4W6LYbieg=; b=oMUfY5zD2TA4
	bJ+E4+wKbxe4upbYx7WQ/rX3onLAbvA0sITuqCmrJCll9kU0vOP7WdLvqtLnaoFU
	akUmEfMqPJq55dqoU96EFsJ6xf8EJpHUIx0zj9vuuvJPN0zJCO3ocyBCiFZwT/az
	tUVqJKmhMHYo1+9LFPFTc8LS0ay+IEpju3dXbeqXe+Q66EwdIUIlqPp6ikssFRn1
	O8LykVZtFTl0WjqEgSPrCIRi4S5PTw39TeJYnfaZDncpNO8WoG/tpXCApQLdlv4Z
	O1t9PTV4TfALd//ZEKkcqj9bL89fFp8ha6sdsObQhA5rWM4gY+ZWKH6UPwRzfVoO
	JMHWQt1g5g==
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61] (may be forged))
	by mx0b-00190b01.pphosted.com (PPS) with ESMTPS id 448223e2a8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 19:27:54 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
	by prod-mail-ppoint6.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id 50OGB7Ro000815;
	Fri, 24 Jan 2025 14:27:53 -0500
Received: from prod-mail-relay10.akamai.com ([172.27.118.251])
	by prod-mail-ppoint6.akamai.com (PPS) with ESMTP id 4488h20utu-1;
	Fri, 24 Jan 2025 14:27:53 -0500
Received: from [172.19.44.114] (bos-lpa4700a.bos01.corp.akamai.com [172.19.44.114])
	by prod-mail-relay10.akamai.com (Postfix) with ESMTP id 0761965F6F;
	Fri, 24 Jan 2025 19:27:53 +0000 (GMT)
Message-ID: <5a6ad008-61c6-4f65-82b3-a4e538cbb9e8@akamai.com>
Date: Fri, 24 Jan 2025 14:27:53 -0500
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] EDAC/ie31200: work around false positive build warning
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, Arnd Bergmann <arnd@kernel.org>,
        Borislav Petkov <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter
 <rric@kernel.org>, James Ye <jye836@gmail.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250122065031.1321015-1-arnd@kernel.org>
 <CY8PR11MB7134E3B1BE3DC6448EEF36A289E12@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Language: en-US
From: Jason Baron <jbaron@akamai.com>
In-Reply-To: <CY8PR11MB7134E3B1BE3DC6448EEF36A289E12@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_08,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501240132
X-Proofpoint-ORIG-GUID: ffUcjJGD2iJcTVfcFSQmGWRzEdmOR1DC
X-Proofpoint-GUID: ffUcjJGD2iJcTVfcFSQmGWRzEdmOR1DC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_08,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 impostorscore=0
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 clxscore=1011 suspectscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501240133



On 1/22/25 9:18 AM, Zhuo, Qiuxu wrote:
> !-------------------------------------------------------------------|
>    This Message Is From an External Sender
>    This message came from outside your organization.
> |-------------------------------------------------------------------!
> 
>> From: Arnd Bergmann <arnd@kernel.org>
>> [...]
>> Subject: [PATCH] EDAC/ie31200: work around false positive build warning
>>
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> gcc-14 produces a bogus warning in some configurations:
>>
>> drivers/edac/ie31200_edac.c: In function 'ie31200_probe1.isra':
>> drivers/edac/ie31200_edac.c:412:26: error: 'dimm_info' is used uninitialized
>> [-Werror=uninitialized]
>>    412 |         struct dimm_data
>> dimm_info[IE31200_CHANNELS][IE31200_DIMMS_PER_CHANNEL];
>>        |                          ^~~~~~~~~
>> drivers/edac/ie31200_edac.c:412:26: note: 'dimm_info' declared here
>>    412 |         struct dimm_data
>> dimm_info[IE31200_CHANNELS][IE31200_DIMMS_PER_CHANNEL];
>>        |                          ^~~~~~~~~
>>
>> I don't see any way the unintialized access could really happen here, but I can
> 
> It looks like gcc-14 isn't smart enough to recognize that this is a false positive build warning :-).
> Actually, the dim_info[][] array is always initialized by populate_dimm_info().
> 
>> see why the compiler gets confused by the two loops.
>>
>> Instead, rework the two nested loops to only read the addr_decode registers
>> and then keep only one instance of the dimm info structure.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Seems fine with the comment adjustment.

Thanks.

Acked-by: Jason Baron <jbaron@akamai.com>


>> ---
>>   drivers/edac/ie31200_edac.c | 27 +++++++++++++--------------
>>   1 file changed, 13 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c index
>> 4fc16922dc1a..b0ccc54dc66a 100644
>> --- a/drivers/edac/ie31200_edac.c
>> +++ b/drivers/edac/ie31200_edac.c
>> @@ -409,10 +409,9 @@ static int ie31200_probe1(struct pci_dev *pdev, int
>> dev_idx)
>>   	int i, j, ret;
>>   	struct mem_ctl_info *mci = NULL;
>>   	struct edac_mc_layer layers[2];
>> -	struct dimm_data
>> dimm_info[IE31200_CHANNELS][IE31200_DIMMS_PER_CHANNEL];
>>   	void __iomem *window;
>>   	struct ie31200_priv *priv;
>> -	u32 addr_decode, mad_offset;
>> +	u32 addr_decode[IE31200_CHANNELS], mad_offset;
>>
>>   	/*
>>   	 * Kaby Lake, Coffee Lake seem to work like Skylake. Please re-visit
>> @@ -472,17 +471,9 @@ static int ie31200_probe1(struct pci_dev *pdev, int
>> dev_idx)
>>
>>   	/* populate DIMM info */
> 
> This comment also needs to be moved to just above the new location of populate_dimm_info().
> 
>>   	for (i = 0; i < IE31200_CHANNELS; i++) {
>> -		addr_decode = readl(window + mad_offset +
>> +		addr_decode[i] = readl(window + mad_offset +
>>   					(i * 4));
>> -		edac_dbg(0, "addr_decode: 0x%x\n", addr_decode);
>> -		for (j = 0; j < IE31200_DIMMS_PER_CHANNEL; j++) {
>> -			populate_dimm_info(&dimm_info[i][j], addr_decode,
>> j,
>> -					   skl);
>> -			edac_dbg(0, "size: 0x%x, rank: %d, width: %d\n",
>> -				 dimm_info[i][j].size,
>> -				 dimm_info[i][j].dual_rank,
>> -				 dimm_info[i][j].x16_width);
>> -		}
>> +		edac_dbg(0, "addr_decode: 0x%x\n", addr_decode[i]);
>>   	}
>>
>>   	/*
>> @@ -493,14 +484,22 @@ static int ie31200_probe1(struct pci_dev *pdev, int
>> dev_idx)
>>   	 */
>>   	for (i = 0; i < IE31200_DIMMS_PER_CHANNEL; i++) {
>>   		for (j = 0; j < IE31200_CHANNELS; j++) {
>> +			struct dimm_data dimm_info;
>>   			struct dimm_info *dimm;
>>   			unsigned long nr_pages;
>>
>> -			nr_pages = IE31200_PAGES(dimm_info[j][i].size, skl);
> 
> Move the comment here.
> 
>> +			populate_dimm_info(&dimm_info, addr_decode[j], i,
>> +					   skl);
>> +			edac_dbg(0, "size: 0x%x, rank: %d, width: %d\n",
>> +				 dimm_info.size,
>> +				 dimm_info.dual_rank,
>> +				 dimm_info.x16_width);
>> +
>> +			nr_pages = IE31200_PAGES(dimm_info.size, skl);
>>   			if (nr_pages == 0)
>>   				continue;
>>
>> -			if (dimm_info[j][i].dual_rank) {
>> +			if (dimm_info.dual_rank) {
>>   				nr_pages = nr_pages / 2;
>>   				dimm = edac_get_dimm(mci, (i * 2) + 1, j, 0);
>>   				dimm->nr_pages = nr_pages;
>> --
>> 2.39.5
>>
> 

