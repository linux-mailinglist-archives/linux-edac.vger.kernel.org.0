Return-Path: <linux-edac+bounces-2606-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B9D9D5D50
	for <lists+linux-edac@lfdr.de>; Fri, 22 Nov 2024 11:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C14CE28362F
	for <lists+linux-edac@lfdr.de>; Fri, 22 Nov 2024 10:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B99F1D63FC;
	Fri, 22 Nov 2024 10:31:44 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7369C1304BA;
	Fri, 22 Nov 2024 10:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732271504; cv=none; b=Uh2PfqzD+i+Yq0qoointzYd2Vn1jwx88JVVrAtjGqCbU1UvXoYL8syKkRUKsJljb81nNBMbRwItGTnDIJKKdS6xIhJuqjg17zeSK9psgQ51iImtBbugRxWsiEh6xWaxD51dQZMz9y9nehuas7dakHF9esgwaWBchOqtyooq6uPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732271504; c=relaxed/simple;
	bh=R/wM2TOsSUpo1Ucglh5txdVqJ2VkhEGCDpQqQlknGVg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fES/dWHaiA8MkMKirHqs2oABvd5EWbMWGlWUq+VYeY+bgrpxQpS0kjIg+nbddIcS7kzgDPRjvr7ntLBH6Q7hrpAqZD5m9w4aNIKKwrlG7uqI4Y3cY34gg8xSLVDbDxDaDV7n2MBL2yyhjUaWHsxGLmlYjGZW3AyqAYWVowBpNzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xvrwx5rplz6LDJ4;
	Fri, 22 Nov 2024 18:31:13 +0800 (CST)
Received: from frapeml500006.china.huawei.com (unknown [7.182.85.219])
	by mail.maildlp.com (Postfix) with ESMTPS id 2838B140A70;
	Fri, 22 Nov 2024 18:31:39 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500006.china.huawei.com (7.182.85.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 22 Nov 2024 11:31:38 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Fri, 22 Nov 2024 11:31:38 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "mchehab@kernel.org"
	<mchehab@kernel.org>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>
Subject: RE: [PATCH 03/13] rasdaemon: cxl: Add automatic indexing for storing
 CXL fields in SQLite database
Thread-Topic: [PATCH 03/13] rasdaemon: cxl: Add automatic indexing for storing
 CXL fields in SQLite database
Thread-Index: AQHbOzMDAZEv+G3ov0igkks6DwRDQrLByaqAgAFTOAA=
Date: Fri, 22 Nov 2024 10:31:38 +0000
Message-ID: <1885c10881b04c4083e8742082d68b36@huawei.com>
References: <20241120095923.1891-1-shiju.jose@huawei.com>
	<20241120095923.1891-4-shiju.jose@huawei.com>
 <20241121151701.00007bea@huawei.com>
In-Reply-To: <20241121151701.00007bea@huawei.com>
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
>From: Jonathan Cameron <jonathan.cameron@huawei.com>
>Sent: 21 November 2024 15:17
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: linux-edac@vger.kernel.org; linux-cxl@vger.kernel.org;
>mchehab@kernel.org; dave.jiang@intel.com; dan.j.williams@intel.com;
>alison.schofield@intel.com; nifan.cxl@gmail.com; vishal.l.verma@intel.com;
>ira.weiny@intel.com; dave@stgolabs.net; linux-kernel@vger.kernel.org;
>Linuxarm <linuxarm@huawei.com>; tanxiaofei <tanxiaofei@huawei.com>;
>Zengtao (B) <prime.zeng@hisilicon.com>
>Subject: Re: [PATCH 03/13] rasdaemon: cxl: Add automatic indexing for stor=
ing
>CXL fields in SQLite database
>
>On Wed, 20 Nov 2024 09:59:13 +0000
><shiju.jose@huawei.com> wrote:
>
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> When the CXL specification adds new fields to the common header of CXL
>> event records, manual updates to the indexing are required to store
>> these CXL fields in the SQLite database. This update introduces
>> automatic indexing to facilitate the storage of CXL fields in the
>> SQLite database, eliminating the need for manual update to indexing.
>>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>
>Using 0 as an error code seems odd, maybe a negative instead?
>With that changed to say -1 then this looks good to me.

Will change error code to -1

Thanks,
Shiju
>
>Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
>
>> ---
>>  ras-record.c | 134
>> ++++++++++++++++++++++++++++-----------------------
>>  1 file changed, 74 insertions(+), 60 deletions(-)
>>
>> diff --git a/ras-record.c b/ras-record.c index b4a1abd..9e68158 100644
>> --- a/ras-record.c
>> +++ b/ras-record.c
>> @@ -780,23 +780,25 @@ int ras_store_cxl_overflow_event(struct
>> ras_events *ras, struct ras_cxl_overflow
>>
>>  static int ras_store_cxl_common_hdr(sqlite3_stmt *stmt, struct
>> ras_cxl_event_common_hdr *hdr)  {
>> +	int idx =3D 1;
>> +
>>  	if (!stmt || !hdr)
>>  		return 0;
>>
>> -	sqlite3_bind_text(stmt, 1, hdr->timestamp, -1, NULL);
>> -	sqlite3_bind_text(stmt, 2, hdr->memdev, -1, NULL);
>> -	sqlite3_bind_text(stmt, 3, hdr->host, -1, NULL);
>> -	sqlite3_bind_int64(stmt, 4, hdr->serial);
>> -	sqlite3_bind_text(stmt, 5, hdr->log_type, -1, NULL);
>> -	sqlite3_bind_text(stmt, 6, hdr->hdr_uuid, -1, NULL);
>> -	sqlite3_bind_int(stmt, 7, hdr->hdr_flags);
>> -	sqlite3_bind_int(stmt, 8, hdr->hdr_handle);
>> -	sqlite3_bind_int(stmt, 9, hdr->hdr_related_handle);
>> -	sqlite3_bind_text(stmt, 10, hdr->hdr_timestamp, -1, NULL);
>> -	sqlite3_bind_int(stmt, 11, hdr->hdr_length);
>> -	sqlite3_bind_int(stmt, 12, hdr->hdr_maint_op_class);
>> -
>> -	return 0;
>> +	sqlite3_bind_text(stmt, idx++, hdr->timestamp, -1, NULL);
>> +	sqlite3_bind_text(stmt, idx++, hdr->memdev, -1, NULL);
>> +	sqlite3_bind_text(stmt, idx++, hdr->host, -1, NULL);
>> +	sqlite3_bind_int64(stmt, idx++, hdr->serial);
>> +	sqlite3_bind_text(stmt, idx++, hdr->log_type, -1, NULL);
>> +	sqlite3_bind_text(stmt, idx++, hdr->hdr_uuid, -1, NULL);
>> +	sqlite3_bind_int(stmt, idx++, hdr->hdr_flags);
>> +	sqlite3_bind_int(stmt, idx++, hdr->hdr_handle);
>> +	sqlite3_bind_int(stmt, idx++, hdr->hdr_related_handle);
>> +	sqlite3_bind_text(stmt, idx++, hdr->hdr_timestamp, -1, NULL);
>> +	sqlite3_bind_int(stmt, idx++, hdr->hdr_length);
>> +	sqlite3_bind_int(stmt, idx++, hdr->hdr_maint_op_class);
>> +
>> +	return idx;
>>  }
>>
>>  /*
>> @@ -827,15 +829,18 @@ static const struct db_table_descriptor
>> cxl_generic_event_tab =3D {
>>
>>  int ras_store_cxl_generic_event(struct ras_events *ras, struct
>> ras_cxl_generic_event *ev)  {
>> -	int rc;
>> +	int rc, idx;
>>  	struct sqlite3_priv *priv =3D ras->db_priv;
>>
>>  	if (!priv || !priv->stmt_cxl_generic_event)
>>  		return 0;
>>  	log(TERM, LOG_INFO, "cxl_generic_event store: %p\n",
>> priv->stmt_cxl_generic_event);
>>
>> -	ras_store_cxl_common_hdr(priv->stmt_cxl_generic_event, &ev->hdr);
>> -	sqlite3_bind_blob(priv->stmt_cxl_generic_event, 13, ev->data,
>> +	idx =3D ras_store_cxl_common_hdr(priv->stmt_cxl_generic_event, &ev-
>>hdr);
>> +	if (!idx)
>> +		return 0;
>Seems like an odd form of error code as without looking at implementation =
it
>might seem reasonable for that call to return 0 because it didn't add anyt=
hin to
>idx?
>
>> +
>> +	sqlite3_bind_blob(priv->stmt_cxl_generic_event, idx++, ev->data,
>>  			  CXL_EVENT_RECORD_DATA_LENGTH, NULL);
>>
>>  	rc =3D sqlite3_step(priv->stmt_cxl_generic_event);
>> @@ -891,7 +896,7 @@ static const struct db_table_descriptor
>> cxl_general_media_event_tab =3D {  int
>ras_store_cxl_general_media_event(struct ras_events *ras,
>>  				      struct ras_cxl_general_media_event *ev)  {
>> -	int rc;
>> +	int rc, idx;
>>  	struct sqlite3_priv *priv =3D ras->db_priv;
>>
>>  	if (!priv || !priv->stmt_cxl_general_media_event)
>> @@ -899,20 +904,23 @@ int ras_store_cxl_general_media_event(struct
>ras_events *ras,
>>  	log(TERM, LOG_INFO, "cxl_general_media_event store: %p\n",
>>  	    priv->stmt_cxl_general_media_event);
>>
>> -	ras_store_cxl_common_hdr(priv->stmt_cxl_general_media_event, &ev-
>>hdr);
>> -	sqlite3_bind_int64(priv->stmt_cxl_general_media_event, 13, ev->dpa);
>> -	sqlite3_bind_int(priv->stmt_cxl_general_media_event, 14, ev-
>>dpa_flags);
>> -	sqlite3_bind_int(priv->stmt_cxl_general_media_event, 15, ev-
>>descriptor);
>> -	sqlite3_bind_int(priv->stmt_cxl_general_media_event, 16, ev->type);
>> -	sqlite3_bind_int(priv->stmt_cxl_general_media_event, 17, ev-
>>transaction_type);
>> -	sqlite3_bind_int(priv->stmt_cxl_general_media_event, 18, ev->channel);
>> -	sqlite3_bind_int(priv->stmt_cxl_general_media_event, 19, ev->rank);
>> -	sqlite3_bind_int(priv->stmt_cxl_general_media_event, 20, ev->device);
>> -	sqlite3_bind_blob(priv->stmt_cxl_general_media_event, 21, ev-
>>comp_id,
>> +	idx =3D ras_store_cxl_common_hdr(priv->stmt_cxl_general_media_event,
>&ev->hdr);
>> +	if (!idx)
>As above,
>> +		return 0;
>> +
>> +	sqlite3_bind_int64(priv->stmt_cxl_general_media_event, idx++, ev-
>>dpa);
>> +	sqlite3_bind_int(priv->stmt_cxl_general_media_event, idx++, ev-
>>dpa_flags);
>> +	sqlite3_bind_int(priv->stmt_cxl_general_media_event, idx++, ev-
>>descriptor);
>> +	sqlite3_bind_int(priv->stmt_cxl_general_media_event, idx++, ev->type);
>> +	sqlite3_bind_int(priv->stmt_cxl_general_media_event, idx++, ev-
>>transaction_type);
>> +	sqlite3_bind_int(priv->stmt_cxl_general_media_event, idx++, ev-
>>channel);
>> +	sqlite3_bind_int(priv->stmt_cxl_general_media_event, idx++, ev->rank);
>> +	sqlite3_bind_int(priv->stmt_cxl_general_media_event, idx++, ev-
>>device);
>> +	sqlite3_bind_blob(priv->stmt_cxl_general_media_event, idx++,
>> +ev->comp_id,
>>  			  CXL_EVENT_GEN_MED_COMP_ID_SIZE, NULL);
>> -	sqlite3_bind_int64(priv->stmt_cxl_general_media_event, 22, ev->hpa);
>> -	sqlite3_bind_text(priv->stmt_cxl_general_media_event, 23, ev->region,
>-1, NULL);
>> -	sqlite3_bind_text(priv->stmt_cxl_general_media_event, 24, ev-
>>region_uuid, -1, NULL);
>> +	sqlite3_bind_int64(priv->stmt_cxl_general_media_event, idx++, ev-
>>hpa);
>> +	sqlite3_bind_text(priv->stmt_cxl_general_media_event, idx++, ev-
>>region, -1, NULL);
>> +	sqlite3_bind_text(priv->stmt_cxl_general_media_event, idx++,
>> +ev->region_uuid, -1, NULL);
>>
>>  	rc =3D sqlite3_step(priv->stmt_cxl_general_media_event);
>>  	if (rc !=3D SQLITE_OK && rc !=3D SQLITE_DONE) @@ -970,7 +978,7 @@
>static
>> const struct db_table_descriptor cxl_dram_event_tab =3D {
>>
>>  int ras_store_cxl_dram_event(struct ras_events *ras, struct
>> ras_cxl_dram_event *ev)  {
>> -	int rc;
>> +	int rc, idx;
>>  	struct sqlite3_priv *priv =3D ras->db_priv;
>>
>>  	if (!priv || !priv->stmt_cxl_dram_event) @@ -978,24 +986,27 @@ int
>> ras_store_cxl_dram_event(struct ras_events *ras, struct ras_cxl_dram_eve=
nt
>*
>>  	log(TERM, LOG_INFO, "cxl_dram_event store: %p\n",
>>  	    priv->stmt_cxl_dram_event);
>>
>> -	ras_store_cxl_common_hdr(priv->stmt_cxl_dram_event, &ev->hdr);
>> -	sqlite3_bind_int64(priv->stmt_cxl_dram_event, 13, ev->dpa);
>> -	sqlite3_bind_int(priv->stmt_cxl_dram_event, 14, ev->dpa_flags);
>> -	sqlite3_bind_int(priv->stmt_cxl_dram_event, 15, ev->descriptor);
>> -	sqlite3_bind_int(priv->stmt_cxl_dram_event, 16, ev->type);
>> -	sqlite3_bind_int(priv->stmt_cxl_dram_event, 17, ev->transaction_type);
>> -	sqlite3_bind_int(priv->stmt_cxl_dram_event, 18, ev->channel);
>> -	sqlite3_bind_int(priv->stmt_cxl_dram_event, 19, ev->rank);
>> -	sqlite3_bind_int(priv->stmt_cxl_dram_event, 20, ev->nibble_mask);
>> -	sqlite3_bind_int(priv->stmt_cxl_dram_event, 21, ev->bank_group);
>> -	sqlite3_bind_int(priv->stmt_cxl_dram_event, 22, ev->bank);
>> -	sqlite3_bind_int(priv->stmt_cxl_dram_event, 23, ev->row);
>> -	sqlite3_bind_int(priv->stmt_cxl_dram_event, 24, ev->column);
>> -	sqlite3_bind_blob(priv->stmt_cxl_dram_event, 25, ev->cor_mask,
>> +	idx =3D ras_store_cxl_common_hdr(priv->stmt_cxl_dram_event, &ev-
>>hdr);
>> +	if (!idx)
>As above.
>
>> +		return 0;
>> +
>> +	sqlite3_bind_int64(priv->stmt_cxl_dram_event, idx++, ev->dpa);
>> +	sqlite3_bind_int(priv->stmt_cxl_dram_event, idx++, ev->dpa_flags);
>> +	sqlite3_bind_int(priv->stmt_cxl_dram_event, idx++, ev->descriptor);
>> +	sqlite3_bind_int(priv->stmt_cxl_dram_event, idx++, ev->type);
>> +	sqlite3_bind_int(priv->stmt_cxl_dram_event, idx++, ev-
>>transaction_type);
>> +	sqlite3_bind_int(priv->stmt_cxl_dram_event, idx++, ev->channel);
>> +	sqlite3_bind_int(priv->stmt_cxl_dram_event, idx++, ev->rank);
>> +	sqlite3_bind_int(priv->stmt_cxl_dram_event, idx++, ev->nibble_mask);
>> +	sqlite3_bind_int(priv->stmt_cxl_dram_event, idx++, ev->bank_group);
>> +	sqlite3_bind_int(priv->stmt_cxl_dram_event, idx++, ev->bank);
>> +	sqlite3_bind_int(priv->stmt_cxl_dram_event, idx++, ev->row);
>> +	sqlite3_bind_int(priv->stmt_cxl_dram_event, idx++, ev->column);
>> +	sqlite3_bind_blob(priv->stmt_cxl_dram_event, idx++, ev->cor_mask,
>>  			  CXL_EVENT_DER_CORRECTION_MASK_SIZE, NULL);
>> -	sqlite3_bind_int64(priv->stmt_cxl_dram_event, 26, ev->hpa);
>> -	sqlite3_bind_text(priv->stmt_cxl_dram_event, 27, ev->region, -1, NULL)=
;
>> -	sqlite3_bind_text(priv->stmt_cxl_dram_event, 28, ev->region_uuid, -1,
>NULL);
>> +	sqlite3_bind_int64(priv->stmt_cxl_dram_event, idx++, ev->hpa);
>> +	sqlite3_bind_text(priv->stmt_cxl_dram_event, idx++, ev->region, -1,
>NULL);
>> +	sqlite3_bind_text(priv->stmt_cxl_dram_event, idx++, ev->region_uuid,
>> +-1, NULL);
>>
>>  	rc =3D sqlite3_step(priv->stmt_cxl_dram_event);
>>  	if (rc !=3D SQLITE_OK && rc !=3D SQLITE_DONE) @@ -1047,7 +1058,7 @@
>> static const struct db_table_descriptor cxl_memory_module_event_tab =3D
>> {  int ras_store_cxl_memory_module_event(struct ras_events *ras,
>>  				      struct ras_cxl_memory_module_event *ev)
>{
>> -	int rc;
>> +	int rc, idx;
>>  	struct sqlite3_priv *priv =3D ras->db_priv;
>>
>>  	if (!priv || !priv->stmt_cxl_memory_module_event)
>> @@ -1055,16 +1066,19 @@ int ras_store_cxl_memory_module_event(struct
>ras_events *ras,
>>  	log(TERM, LOG_INFO, "cxl_memory_module_event store: %p\n",
>>  	    priv->stmt_cxl_memory_module_event);
>>
>> -	ras_store_cxl_common_hdr(priv->stmt_cxl_memory_module_event,
>&ev->hdr);
>> -	sqlite3_bind_int(priv->stmt_cxl_memory_module_event, 13, ev-
>>event_type);
>> -	sqlite3_bind_int(priv->stmt_cxl_memory_module_event, 14, ev-
>>health_status);
>> -	sqlite3_bind_int(priv->stmt_cxl_memory_module_event, 15, ev-
>>media_status);
>> -	sqlite3_bind_int(priv->stmt_cxl_memory_module_event, 16, ev-
>>life_used);
>> -	sqlite3_bind_int(priv->stmt_cxl_memory_module_event, 17, ev-
>>dirty_shutdown_cnt);
>> -	sqlite3_bind_int(priv->stmt_cxl_memory_module_event, 18, ev-
>>cor_vol_err_cnt);
>> -	sqlite3_bind_int(priv->stmt_cxl_memory_module_event, 19, ev-
>>cor_per_err_cnt);
>> -	sqlite3_bind_int(priv->stmt_cxl_memory_module_event, 20, ev-
>>device_temp);
>> -	sqlite3_bind_int(priv->stmt_cxl_memory_module_event, 21, ev-
>>add_status);
>> +	idx =3D ras_store_cxl_common_hdr(priv-
>>stmt_cxl_memory_module_event, &ev->hdr);
>> +	if (!idx)
>as above
>> +		return 0;
>> +
>> +	sqlite3_bind_int(priv->stmt_cxl_memory_module_event, idx++, ev-
>>event_type);
>> +	sqlite3_bind_int(priv->stmt_cxl_memory_module_event, idx++, ev-
>>health_status);
>> +	sqlite3_bind_int(priv->stmt_cxl_memory_module_event, idx++, ev-
>>media_status);
>> +	sqlite3_bind_int(priv->stmt_cxl_memory_module_event, idx++, ev-
>>life_used);
>> +	sqlite3_bind_int(priv->stmt_cxl_memory_module_event, idx++, ev-
>>dirty_shutdown_cnt);
>> +	sqlite3_bind_int(priv->stmt_cxl_memory_module_event, idx++, ev-
>>cor_vol_err_cnt);
>> +	sqlite3_bind_int(priv->stmt_cxl_memory_module_event, idx++, ev-
>>cor_per_err_cnt);
>> +	sqlite3_bind_int(priv->stmt_cxl_memory_module_event, idx++, ev-
>>device_temp);
>> +	sqlite3_bind_int(priv->stmt_cxl_memory_module_event, idx++,
>> +ev->add_status);
>>
>>  	rc =3D sqlite3_step(priv->stmt_cxl_memory_module_event);
>>  	if (rc !=3D SQLITE_OK && rc !=3D SQLITE_DONE)


